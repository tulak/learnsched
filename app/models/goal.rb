class Goal < ApplicationRecord
  belongs_to :goal_template
  belongs_to :user
  has_many :task_schedules, dependent: :destroy
  has_many :tasks, through: :goal_template

  def progress
    @progress ||= Progress.new(self)
  end
end
