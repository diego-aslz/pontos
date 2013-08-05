class Period < ActiveRecord::Base
  attr_accessible :start, :finish, :day

  belongs_to :user
  validates_presence_of :user_id

  @@horaries = nil

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

  def self.horaries
    return @@horaries if @@horaries
    @@horaries = []
    0.upto 23 do |h|
      0.upto 11 do |m|
        @@horaries << "#{sprintf("%02d", h)}:#{sprintf("%02d", m*5)}"
      end
    end
    @@horaries
  end

  def load_morning
    self.start = '08:00'
    self.finish = '12:00'
  end

  def load_afternoon
    self.start = '14:00'
    self.finish = '18:00'
  end

  def total_time
    Time.strptime(finish, "%H:%M") - Time.strptime(start, "%H:%M")
  end
end
