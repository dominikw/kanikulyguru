require 'toggl_api'

class HolidayCalculator
  VACATION_PROJECTS = [3561207]
  NOT_WORK_PROJECTS = VACATION_PROJECTS

  def available_holiday(toggl_token, dg_start)
    entries = fetch_entries(toggl_token, DateTime.parse(dg_start))
    vacation_entries = entries.select { |entry| VACATION_PROJECTS.include?(entry.pid) }
    vacation = sum_duration(vacation_entries)
    worked = sum_duration(work_entries)
    earned = worked / 16.0
    left = earned - vacation
    {
      hours_left: to_hours(left),
      worked: to_hours(worked),
      earned: to_hours(earned),
      vacation: to_hours(vacation)
    }
  end

  private

  def fetch_entries(toggl_token, dg_start)
    base = Toggl::Base.new toggl_token
    entries = []
    i_date = dg_start
    while i_date < DateTime.now
      next_date = [i_date + 150, DateTime.now].min
      entries += base.time_entries(i_date, next_date)
      i_date = next_date + 1
    end
    entries
  end

  def sum_duration(entries)
    entries.map(&:duration).inject(0, &:+)
  end

  def to_hours(work_duration)
    work_duration.to_f / 60.0 / 60.0
  end
end
