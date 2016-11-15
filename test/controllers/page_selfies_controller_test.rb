require 'test_helper'

class PageSelfiesControllerTest < ActionController::TestCase
  setup do
    @page_selfy = page_selfies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_selfies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_selfy" do
    assert_difference('PageSelfy.count') do
      post :create, page_selfy: { content_type: @page_selfy.content_type, data: @page_selfy.data, page_id: @page_selfy.page_id }
    end

    assert_redirected_to page_selfy_path(assigns(:page_selfy))
  end

  test "should show page_selfy" do
    get :show, id: @page_selfy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_selfy
    assert_response :success
  end

  test "should update page_selfy" do
    patch :update, id: @page_selfy, page_selfy: { content_type: @page_selfy.content_type, data: @page_selfy.data, page_id: @page_selfy.page_id }
    assert_redirected_to page_selfy_path(assigns(:page_selfy))
  end

  test "should destroy page_selfy" do
    assert_difference('PageSelfy.count', -1) do
      delete :destroy, id: @page_selfy
    end

    assert_redirected_to page_selfies_path
  end
end
