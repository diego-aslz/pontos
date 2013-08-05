class PeriodsController < InheritedResources::Base
  before_filter :login_required

  def index
    begin
      @base = Date.strptime params[:base], '%Y-%m'
    rescue
      @base = Period.order(:day).last.day
    end
    @periods = Period.by_user(current_user).by_month @base
    index!
  end

  def new
    @period = Period.new
    @period.day = Date.strptime(params[:day]) if params[:day]
    if params[:morning]
      @period.load_morning
    else
      @period.load_afternoon
    end
    new!
  end

  def create
    @period = Period.new(params[:period])
    @period.user = current_user
    create! do |success,error|
      success.html { redirect_to action: :index }
    end
  end

  def update
    @period = Period.find(params[:id])
    unless @period.user_id == current_user.id
      redirect_to root_path
      return
    end
    update! do |success,error|
      success.html { redirect_to action: :index }
    end
  end
end
