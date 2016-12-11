require 'test_helper'

class GoalsControllerTest < ActionController::TestCase
  setup do
    @goal = goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal" do
    assert_difference('Goal.count') do
      post :create, goal: { back_val1: @goal.back_val1, back_val2: @goal.back_val2, body_size_arm: @goal.body_size_arm, body_size_bust: @goal.body_size_bust, body_size_calf_right: @goal.body_size_calf_right, body_size_hip: @goal.body_size_hip, body_size_leg_right: @goal.body_size_leg_right, body_size_neck: @goal.body_size_neck, body_size_waist: @goal.body_size_waist, carbohydrate_val1: @goal.carbohydrate_val1, carbohydrate_val2: @goal.carbohydrate_val2, end_date: @goal.end_date, fat_per_val1: @goal.fat_per_val1, fat_val1: @goal.fat_val1, fat_val2: @goal.fat_val2, leg_val1: @goal.leg_val1, leg_val2: @goal.leg_val2, memo: @goal.memo, protein_val1: @goal.protein_val1, protein_val2: @goal.protein_val2, pull_val1: @goal.pull_val1, pull_val2: @goal.pull_val2, push_val1: @goal.push_val1, push_val2: @goal.push_val2, start_date: @goal.start_date, user_id: @goal.user_id, vegetable_val1: @goal.vegetable_val1, vegetable_val2: @goal.vegetable_val2, weight_val1: @goal.weight_val1 }
    end

    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should show goal" do
    get :show, id: @goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goal
    assert_response :success
  end

  test "should update goal" do
    patch :update, id: @goal, goal: { back_val1: @goal.back_val1, back_val2: @goal.back_val2, body_size_arm: @goal.body_size_arm, body_size_bust: @goal.body_size_bust, body_size_calf_right: @goal.body_size_calf_right, body_size_hip: @goal.body_size_hip, body_size_leg_right: @goal.body_size_leg_right, body_size_neck: @goal.body_size_neck, body_size_waist: @goal.body_size_waist, carbohydrate_val1: @goal.carbohydrate_val1, carbohydrate_val2: @goal.carbohydrate_val2, end_date: @goal.end_date, fat_per_val1: @goal.fat_per_val1, fat_val1: @goal.fat_val1, fat_val2: @goal.fat_val2, leg_val1: @goal.leg_val1, leg_val2: @goal.leg_val2, memo: @goal.memo, protein_val1: @goal.protein_val1, protein_val2: @goal.protein_val2, pull_val1: @goal.pull_val1, pull_val2: @goal.pull_val2, push_val1: @goal.push_val1, push_val2: @goal.push_val2, start_date: @goal.start_date, user_id: @goal.user_id, vegetable_val1: @goal.vegetable_val1, vegetable_val2: @goal.vegetable_val2, weight_val1: @goal.weight_val1 }
    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should destroy goal" do
    assert_difference('Goal.count', -1) do
      delete :destroy, id: @goal
    end

    assert_redirected_to goals_path
  end
end
