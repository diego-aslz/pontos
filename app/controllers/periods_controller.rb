class PeriodsController < InheritedResources::Base
  def index
    begin
      @base = Date.strptime params[:base], '%Y-%m'
    rescue
      @base = Period.order(:day).last.day
    end
    @periods = Period.by_month @base
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
    create! do |success,error|
      success.html { redirect_to action: :index }
    end
  end

  def update
    update! do |success,error|
      success.html { redirect_to action: :index }
    end
  end
end
