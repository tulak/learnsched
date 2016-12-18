class GoalsController < ApplicationController
  def dashboard
    @goals = current_user.goals
    @global_proress = GlobalProgress.new current_user

    @tasks_after_deadline = current_user.task_schedules.where('task_schedules.scheduled_at < ? AND (completed = ? OR completed IS NULL)', Time.current, false)
  end
  
  def new
    @new_goal_form = NewGoalForm.new new_goal_form_params[:search_query], current_user
  end

  def enroll
    goal_template = GoalTemplate.find(params[:goal_template_id])
    goal = Goal.create(user: current_user, goal_template: goal_template)
    redirect_to goal
  end

  def my
    @goals = current_user.goals
  end

  def show
    @goal = Goal.find(params[:id])
    @goal_template = @goal.goal_template
  end

  def task
    @task = Task.find(params[:task_id])
    @goal = Goal.find(params[:id])
    @task_schedule = @task.task_schedule_for @goal
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    redirect_to dashboard_path
  end

  def new_goal_form_params
    params.permit(new_goal_form: [:search_query]).try(:[], :new_goal_form) || {}
  end

  def calendar
  end
end
