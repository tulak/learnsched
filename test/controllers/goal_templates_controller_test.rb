require 'test_helper'

class GoalTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goal_template = goal_templates(:one)
  end

  test "should get index" do
    get goal_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_goal_template_url
    assert_response :success
  end

  test "should create goal_template" do
    assert_difference('GoalTemplate.count') do
      post goal_templates_url, params: { goal_template: { name: @goal_template.name, owner: @goal_template.owner, public: @goal_template.public } }
    end

    assert_redirected_to goal_template_url(GoalTemplate.last)
  end

  test "should show goal_template" do
    get goal_template_url(@goal_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_goal_template_url(@goal_template)
    assert_response :success
  end

  test "should update goal_template" do
    patch goal_template_url(@goal_template), params: { goal_template: { name: @goal_template.name, owner: @goal_template.owner, public: @goal_template.public } }
    assert_redirected_to goal_template_url(@goal_template)
  end

  test "should destroy goal_template" do
    assert_difference('GoalTemplate.count', -1) do
      delete goal_template_url(@goal_template)
    end

    assert_redirected_to goal_templates_url
  end
end
