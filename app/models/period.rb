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
    unless user and day
      self.start = '08:00'
      self.finish = '12:00'
      return
    end

    wday = day.wday
    hor = user.horaries[wday]
    unless hor
      self.start = '08:00'
      self.finish = '12:00'
      return
    end

    self.start = hor[0] && !hor[0].blank? ? hor[0] : '08:00'
    self.finish = hor[1] && !hor[1].blank? ? hor[1] : '12:00'
  end

  def load_afternoon(user = nil)
    unless user and day
      self.start = '14:00'
      self.finish = '18:00'
      return
    end

    wday = day.wday
    hor = user.horaries[wday]
    unless hor
      self.start = '14:00'
      self.finish = '18:00'
      return
    end

    self.start = hor[2] && !hor[2].blank? ? hor[2] : '14:00'
    self.finish = hor[3] && !hor[3].blank? ? hor[3] : '18:00'
  end

  def total_time
    Time.strptime(finish, "%H:%M") - Time.strptime(start, "%H:%M")
  end
end
