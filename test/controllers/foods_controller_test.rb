require 'test_helper'

class FoodsControllerTest < ActionController::TestCase
  setup do
    @food = foods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food" do
    assert_difference('Food.count') do
      post :create, food: { calorie: @food.calorie, carbohydrate: @food.carbohydrate, diet_id: @food.diet_id, diet_memo: @food.diet_memo, fat: @food.fat, name: @food.name, protein: @food.protein, vegetable: @food.vegetable }
    end

    assert_redirected_to food_path(assigns(:food))
  end

  test "should show food" do
    get :show, id: @food
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food
    assert_response :success
  end

  test "should update food" do
    patch :update, id: @food, food: { calorie: @food.calorie, carbohydrate: @food.carbohydrate, diet_id: @food.diet_id, diet_memo: @food.diet_memo, fat: @food.fat, name: @food.name, protein: @food.protein, vegetable: @food.vegetable }
    assert_redirected_to food_path(assigns(:food))
  end

  test "should destroy food" do
    assert_difference('Food.count', -1) do
      delete :destroy, id: @food
    end

    assert_redirected_to foods_path
  end
end
