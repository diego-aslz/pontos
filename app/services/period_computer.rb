class PeriodComputer
  attr_accessor :from_date, :to_date, :user

  def initialize(user, from_date=nil,to_date=nil)
    @from_date = from_date || Period.by_user(user).minimum(:day)
    @to_date = to_date || from_date || Period.by_user(user).maximum(:day)
    @worked_time = nil
    @expected_time = nil
    @user = user
  end

  def expected_time
    return @expected_time if @expected_time
    @expected_time = 0
    @from_date.upto @to_date do |date|
      @expected_time += if date.saturday? || date.sunday?
        0.hours
      else
        8.hours
      end
    end if @from_date
    @expected_time
  end

  def worked_time
    return @worked_time if @worked_time
    @worked_time = 0
    Period.by_user(@user).by_period(@from_date, @to_date).each do |p|
      @worked_time += p.total_time
    end
    @worked_time
  end

  def balance
    worked_time - expected_time
  end

  def total_balance
    (@user.initial_balance || 0).hours + worked_time - expected_time
  end
end