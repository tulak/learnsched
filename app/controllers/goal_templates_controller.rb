class GoalTemplatesController < ApplicationController
  before_action :set_goal_template, only: [:show, :edit, :update, :destroy]

  # GET /goal_templates
  # GET /goal_templates.json
  def index
    @goal_templates = current_user.goal_templates
  end

  # GET /goal_templates/1
  # GET /goal_templates/1.json
  def show
  end

  # GET /goal_templates/new
  def new
    @goal_template = GoalTemplate.new
    @goal_template_form = GoalTemplateForm.new @goal_template, current_user
  end

  # GET /goal_templates/1/edit
  def edit
    @goal_template_form = GoalTemplateForm.new @goal_template, current_user
  end

  def create
    @goal_template = GoalTemplate.new
    @goal_template_form = GoalTemplateForm.new @goal_template, current_user, goal_template_form_params

    if @goal_template_form.save
      render json: { redirect_to: goal_templates_path }
    else
      render json: { errors: @goal_template_form.errors.full_messages }
    end
  end

  # PATCH/PUT /goal_templates/1
  def update
    # binding.pry
    @goal_template_form = GoalTemplateForm.new @goal_template, current_user, goal_template_form_params

    if @goal_template_form.save
      render json: { redirect_to: goal_templates_path }
    else
      render json: { errors: @goal_template_form.errors.full_messages }
    end
  end

  # DELETE /goal_templates/1
  # DELETE /goal_templates/1.json
  def destroy
    @goal_template.destroy
    respond_to do |format|
      format.html { redirect_to goal_templates_url, notice: 'Goal template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal_template
      @goal_template = GoalTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_template_params
      params.require(:goal_template).permit(:name, :public, :owner)
    end

    def goal_template_form_params
      params.require(:goal_template_form).permit(:id, :name, :public,
                                                 levels: [
                                                             :id, :name,
                                                             tasks: [ :id, :name, :description, :resources, :estimated_time]
                                                         ])
    end
end
