class GoalTemplateForm
  include ActiveModel::Model


  delegate :persisted?, to: :goal_template
  attr_reader :goal_template, :name, :owner_id, :public, :current_user, :levels
  def initialize goal_template, current_user, params={}
    @goal_template = goal_template
    @owner_id = current_user.id

    @name = params[:name]
    @public = params[:public]
    @levels = params[:levels] || {}
    unless params.any?
      @name = goal_template.name
      @public = goal_template.public
      @levels = levels_json
    end
    @current_user = current_user
  end

  validates :name, presence: true


  def save
    return false unless valid?

    GoalTemplate.transaction do
      goal_template.name = name
      goal_template.owner_id = current_user.id
      goal_template.public = public

      remove_levels

      goal_template.save!

      levels.each do |_, l|
        # binding.pry
        level = Level.where(id: l[:id]).first || Level.new
        level.name = l[:name]
        level.goal_template = goal_template

        remove_tasks level, l

        level.save!

        l[:tasks].each do |_, t|
          task = Task.where(id: t[:id]).first || Task.new
          task.name = t[:name]
          task.description = t[:description]
          task.resources = t[:resources]
          task.estimated_time = t[:estimated_time]
          task.level = level

          task.save!
        end
      end
      # raise ActiveRecord::Rollback
    end

  rescue ActiveRecord::RecordInvalid => e
    binding.pry
    e.record.errors.messages.each do |field, messages|
      messages.each do |message|
        errors.add field, message
      end
    end
    false
  end

  def remove_levels
    return if goal_template.new_record?

    new_ids = levels.collect{|_, l| l[:id].to_i }
    old_ids = goal_template.level_ids
    ids_to_delete = old_ids - new_ids

    Level.where(id: ids_to_delete).destroy_all
  end

  def remove_tasks level, params_level
    return if level.new_record?

    new_ids = params_level[:tasks].collect{|_, t| t[:id].to_i }
    old_ids = level.task_ids
    ids_to_delete = old_ids - new_ids

    Task.where(id: ids_to_delete).destroy_all
  end

  def levels_json
    return [] if goal_template.new_record?

    goal_template.levels.includes(:tasks).inject({}) do |h, level|
      h[level.id] = {
          id: level.id,
          name: level.name,
          tasks: tasks_json(level)
      }
      h
    end
  end

  def tasks_json level
    level.tasks.inject({}) do |h, task|
      h[task.id] = {
          id: task.id,
          name: task.name,
          description: task.description,
          resources: task.resources,
          estimated_time: task.estimated_time
      }
      h
    end
  end

  def as_json
    {
        id: goal_template.id,
        name: name,
        public: public,
        levels: levels
    }
  end

  def to_model
    goal_template
  end

  def form_url
    if goal_template.persisted?
      Rails.application.routes.url_helpers.goal_template_path(goal_template)
    else
      Rails.application.routes.url_helpers.goal_templates_path
    end
  end

  def form_method
    if goal_template.persisted?
      'put'
    else
      'post'
    end
  end
end