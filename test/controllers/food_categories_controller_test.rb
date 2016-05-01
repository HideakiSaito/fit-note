require 'test_helper'

class FoodCategoriesControllerTest < ActionController::TestCase
  setup do
    @food_category = food_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_category" do
    assert_difference('FoodCategory.count') do
      post :create, food_category: { name: @food_category.name, no: @food_category.no, order: @food_category.order }
    end

    assert_redirected_to food_category_path(assigns(:food_category))
  end

  test "should show food_category" do
    get :show, id: @food_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_category
    assert_response :success
  end

  test "should update food_category" do
    patch :update, id: @food_category, food_category: { name: @food_category.name, no: @food_category.no, order: @food_category.order }
    assert_redirected_to food_category_path(assigns(:food_category))
  end

  test "should destroy food_category" do
    assert_difference('FoodCategory.count', -1) do
      delete :destroy, id: @food_category
    end

    assert_redirected_to food_categories_path
  end
end
