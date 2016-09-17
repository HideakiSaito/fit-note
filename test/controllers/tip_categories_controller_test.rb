require 'test_helper'

class TipCategoriesControllerTest < ActionController::TestCase
  setup do
    @tip_category = tip_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tip_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tip_category" do
    assert_difference('TipCategory.count') do
      post :create, tip_category: { name: @tip_category.name }
    end

    assert_redirected_to tip_category_path(assigns(:tip_category))
  end

  test "should show tip_category" do
    get :show, id: @tip_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tip_category
    assert_response :success
  end

  test "should update tip_category" do
    patch :update, id: @tip_category, tip_category: { name: @tip_category.name }
    assert_redirected_to tip_category_path(assigns(:tip_category))
  end

  test "should destroy tip_category" do
    assert_difference('TipCategory.count', -1) do
      delete :destroy, id: @tip_category
    end

    assert_redirected_to tip_categories_path
  end
end
