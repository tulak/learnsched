class GlobalProgress
  def initialize current_user
    @current_user = current_user
    @tasks = @current_user.tasks
    @task_schedules = @current_user.task_schedules
  end

  def completed
    @task_schedules.where(completed: true).count
  end

  def all
    @tasks.count
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