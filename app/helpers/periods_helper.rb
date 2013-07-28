module PeriodsHelper
  def periods_for(periods, day, morning=false)
    periods.select do |p|
      p.day.strftime('%-d') == day.to_s && (morning ? p.start < '12:00' :
          p.start >= '12:00')
    end
  end

  def show_period(period, day, morning=false)
    if period
      content = "
          <td>#{link_to period.start, edit_period_path(period)}</td>
          <td>#{link_to period.finish, edit_period_path(period)}</td>"
    else
      set_label = t(:set_period)
      content = "
          <td colspan=\"2\"> #{link_to set_label, new_specific_period_path(day,
              morning)}</td>"
    end
    content.html_safe
  end

  def new_specific_period_path(day, morning = false)
    params = ["day=#{day}"]
    params << "morning=1" if morning
    new_period_path + "?" + params.join('&')
  end
end
