require 'toggl_api'

class HolidayCalculator
  VACATION_PROJECTS = [3561207]
  NOT_WORK_PROJECTS = [3561198] + VACATION_PROJECTS

  def available_holiday(toggl_token, dg_start)
    entries = fetch_entries(toggl_token, dg_start)
    work_entries = entries.reject { |entry| NOT_WORK_PROJECTS.include?(entry.pid) }
    vacation_entries = entries.select { |entry| VACATION_PROJECTS.include?(entry.pid) }
    difference = sum_duration(work_entries) / 16.0 - sum_duration(vacation_entries)
    {
      hours_left: to_hours(difference),
      worked: to_hours(sum_duration(work_entries)),
      earned: (to_hours(sum_duration(work_entries)) / 16.0),
      vacation: to_hours(sum_duration(vacation_entries))
    }
  end

  private

  def fetch_entries(toggl_token, dg_start)
    base = Toggl::Base.new toggl_token
    entries = base.time_entries(dg_start, Time.now)
  end

  def sum_duration(entries)
    entries.map(&:duration).inject(0, &:+)
  end

  def to_hours(work_duration)
    work_duration.to_f / 60.0 / 60.0
  end
end
