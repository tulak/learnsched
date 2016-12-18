class TaskSchedule < ApplicationRecord
  belongs_to :goal
  belongs_to :task

  def after_deadline?
    return false if completed
    return false unless scheduled_at
    scheduled_at < Time.current
  end
end
