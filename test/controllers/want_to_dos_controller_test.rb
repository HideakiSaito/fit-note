require 'test_helper'

class WantToDosControllerTest < ActionController::TestCase
  setup do
    @want_to_do = want_to_dos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:want_to_dos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create want_to_do" do
    assert_difference('WantToDo.count') do
      post :create, want_to_do: { category: @want_to_do.category, description: @want_to_do.description, done: @want_to_do.done, estimate: @want_to_do.estimate, status: @want_to_do.status, title: @want_to_do.title, user_id: @want_to_do.user_id }
    end

    assert_redirected_to want_to_do_path(assigns(:want_to_do))
  end

  test "should show want_to_do" do
    get :show, id: @want_to_do
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @want_to_do
    assert_response :success
  end

  test "should update want_to_do" do
    patch :update, id: @want_to_do, want_to_do: { category: @want_to_do.category, description: @want_to_do.description, done: @want_to_do.done, estimate: @want_to_do.estimate, status: @want_to_do.status, title: @want_to_do.title, user_id: @want_to_do.user_id }
    assert_redirected_to want_to_do_path(assigns(:want_to_do))
  end

  test "should destroy want_to_do" do
    assert_difference('WantToDo.count', -1) do
      delete :destroy, id: @want_to_do
    end

    assert_redirected_to want_to_dos_path
  end
end
