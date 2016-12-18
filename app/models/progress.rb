class Progress
  def initialize goal
    @goal = goal
    @tasks_scope = @goal.goal_template.tasks.left_outer_joins(:task_schedules)
  end

  def completed
    @tasks_scope.merge(@goal.task_schedules).where(task_schedules: { completed: true }).count
  end

  def all
    @tasks_scope.count
  end

  def percentage
    p = (completed.to_d / all * 100)
    return 0 if p.nan?
    p.round.to_i
  rescue ZeroDivisionError
    0
  end

  def to_partial_path
    'goals/progress'
  end
end