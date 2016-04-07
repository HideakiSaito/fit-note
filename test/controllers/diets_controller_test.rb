require 'test_helper'

class DietsControllerTest < ActionController::TestCase
  setup do
    @diet = diets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diet" do
    assert_difference('Diet.count') do
      post :create, diet: { name: @diet.name }
    end

    assert_redirected_to diet_path(assigns(:diet))
  end

  test "should show diet" do
    get :show, id: @diet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diet
    assert_response :success
  end

  test "should update diet" do
    patch :update, id: @diet, diet: { name: @diet.name }
    assert_redirected_to diet_path(assigns(:diet))
  end

  test "should destroy diet" do
    assert_difference('Diet.count', -1) do
      delete :destroy, id: @diet
    end

    assert_redirected_to diets_path
  end
end
