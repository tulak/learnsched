class NewGoalForm
  include ActiveModel::Model

  attr_reader :search_query, :current_user
  def initialize search_query, current_user
    @search_query = search_query
    @current_user = current_user
  end

  def filtered_goal_templates
    public = GoalTemplate.where(public: true)
    my = current_user.goal_templates

    if search_query.present?
      public = public.where(['name LIKE ?', "%#{search_query}%"])
      my = my.where(['name LIKE ?', "%#{search_query}%"])
    end

    ids = my.pluck(:id) + public.pluck(:id)

    GoalTemplate.where(id: ids).limit(50)
  end
end