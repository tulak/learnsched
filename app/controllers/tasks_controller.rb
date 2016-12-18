class TasksController < ApplicationController
  def index
    @tasks_schedules = current_user.task_schedules.includes(task: { level: :goal_template })
    c_start = Date.parse(params[:start])
    c_end = Date.parse(params[:end])
    @tasks_schedules = @tasks_schedules.where(scheduled_at: c_start..c_end)
    @tasks_schedules = @tasks_schedules.collect do |task_schedule|
      t = task_schedule.task
      {
          id: t.id,
          goal_id: task_schedule.goal_id,
          task_name: t.name,
          level_name: t.level_name,
          goal_template_name: t.goal_template_name,
          start: task_schedule.scheduled_at,
          end: task_schedule.scheduled_at + t.estimated_time.minutes
      }
    end
    render json: @tasks_schedules.as_json
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def complete
    task = Task.find(params[:id])
    goal = Goal.find(params[:goal_id])

    task_schedule = task.task_schedule_for(goal)
    task_schedule.completed = true
    task_schedule.completed_at = Time.current
    task_schedule.save

    redirect_to :back
  end

  def schedule
    task = Task.find(params[:id])
    goal = Goal.find(params[:goal_id])

    begin
      schedule_at = Time.parse(params[:schedule_at])
    rescue
      flash[:error] = "Please specify valid time"
    else
      task_schedule = task.task_schedule_for(goal)
      task_schedule.scheduled_at = schedule_at
      task_schedule.save
    end
    redirect_to :back
  end
end
