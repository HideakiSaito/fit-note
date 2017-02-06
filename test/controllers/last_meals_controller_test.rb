require 'test_helper'

class LastMealsControllerTest < ActionController::TestCase
  setup do
    @last_meal = last_meals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:last_meals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create last_meal" do
    assert_difference('LastMeal.count') do
      post :create, last_meal: { date: @last_meal.date, food_id: @last_meal.food_id, memo: @last_meal.memo, user_id: @last_meal.user_id }
    end

    assert_redirected_to last_meal_path(assigns(:last_meal))
  end

  test "should show last_meal" do
    get :show, id: @last_meal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @last_meal
    assert_response :success
  end

  test "should update last_meal" do
    patch :update, id: @last_meal, last_meal: { date: @last_meal.date, food_id: @last_meal.food_id, memo: @last_meal.memo, user_id: @last_meal.user_id }
    assert_redirected_to last_meal_path(assigns(:last_meal))
  end

  test "should destroy last_meal" do
    assert_difference('LastMeal.count', -1) do
      delete :destroy, id: @last_meal
    end

    assert_redirected_to last_meals_path
  end
end
