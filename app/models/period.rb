class Period < ActiveRecord::Base
  attr_accessible :start, :finish, :day
  attr_accessor :morning

  belongs_to :user
  validates_presence_of :user_id

  @@morning_horaries = nil
  @@afternoon_horaries = nil

  scope :by_user, ->(user) {
    where(user_id: user.id)
  }
  scope :by_month, ->(date) {
    by_period(date.change(day: 1), date.change(day: -1))
  }
  scope :by_period, ->(start_date, finish_date) {
    where('day between :start and :finish', start: start_date,
        finish: finish_date).order(:day, :start, :finish)
  }

  def load_morning(user = nil)
    unless user and user.default_morning_start
      self.start = '08:00'
    else
      self.start = user.default_morning_start
    end
    unless user and user.default_morning_finish
      self.finish = '12:00'
    else
      self.finish = user.default_morning_finish
    end
  end

  def load_afternoon(user = nil)
    unless user and user.default_afternoon_start
      self.start = '14:00'
    else
      self.start = user.default_afternoon_start
    end
    unless user and user.default_afternoon_finish
      self.finish = '18:00'
    else
      self.finish = user.default_afternoon_finish
    end
  end

  def total_time
    Time.strptime(finish, "%H:%M") - Time.strptime(start, "%H:%M")
  end
end
