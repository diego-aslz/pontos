class Period < ActiveRecord::Base
  attr_accessible :start, :finish, :day

  after_initialize :load_horaries

  @@horaries = nil

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

  def load_horaries
    self.start = '08:00'
    self.finish = '12:00'
  end
end
