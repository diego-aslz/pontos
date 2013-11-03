class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
    load_horaries
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => t(:'helpers.messages.sign_up')
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    load_horaries
  end

  def update
    @user = current_user
    horaries = []
    params[:user].delete(:horaries).each_pair do |i, day|
      horaries[i.to_i] = day
    end

    if @user.update_attributes(params[:user].merge(horaries: horaries))
      redirect_to root_url, :notice => t(:'helpers.messages.updated', model:
          User.model_name.human)
    else
      render :action => 'edit'
    end
  end

  protected

  def load_horaries
    morning = ['08:00', '12:00']
    afternoon = ['14:00', '18:00']
    day = morning + afternoon

    @user.horaries << ['', '', '', ''] if @user.horaries.size < 1 # Sunday
    (6 - @user.horaries.size).times { @user.horaries << day } # Monday - Friday
    @user.horaries << morning + ['', ''] if @user.horaries.size < 7 # Saturday
  end
end
