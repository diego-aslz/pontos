class Period < ActiveRecord::Base
  attr_accessible :start, :finish, :day

  @@horaries = nil

  scope :by_month, ->(date) {
    where('day between :start and :finish', start: date.strftime('%Y-%m-00'),
        finish: date.strftime('%Y-%m-31')).order(:day, :start, :finish)
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
end
