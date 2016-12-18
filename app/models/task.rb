class Task < ApplicationRecord
  belongs_to :level
  has_many :task_schedules

  validates :name, presence: true

  def completed? goal
    task_schedule = goal.task_schedules.where(task_id: id).first
    return false unless task_schedule
    task_schedule.completed?
  end

  def task_schedule_for goal
    goal.task_schedules.where(task_id: id).first || TaskSchedule.new(goal: goal, task: self)
  end

  def estimated_time
    read_attribute(:estimated_time) || 60
  end

  def level_name
    level.name
  end

  def goal_template_name
    level.goal_template.name
  end
end
