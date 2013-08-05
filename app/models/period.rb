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

  def self.morning_horaries
    return @@morning_horaries if @@morning_horaries
    @@morning_horaries = []
    4.upto 14 do |h|
      0.upto 11 do |m|
        @@morning_horaries << "#{sprintf("%02d", h)}:#{sprintf("%02d", m*5)}"
      end
    end
    @@morning_horaries
  end

  def self.afternoon_horaries
    return @@afternoon_horaries if @@afternoon_horaries
    @@afternoon_horaries = []
    11.upto 23 do |h|
      0.upto 11 do |m|
        @@afternoon_horaries << "#{sprintf("%02d", h)}:#{sprintf("%02d", m*5)}"
      end
    end
    @@afternoon_horaries
  end

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
