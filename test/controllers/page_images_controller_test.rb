require 'test_helper'

class PageImagesControllerTest < ActionController::TestCase
  setup do
    @page_image = page_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_image" do
    assert_difference('PageImage.count') do
      post :create, page_image: { content_type: @page_image.content_type, data: @page_image.data, page_id: @page_image.page_id }
    end

    assert_redirected_to page_image_path(assigns(:page_image))
  end

  test "should show page_image" do
    get :show, id: @page_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_image
    assert_response :success
  end

  test "should update page_image" do
    patch :update, id: @page_image, page_image: { content_type: @page_image.content_type, data: @page_image.data, page_id: @page_image.page_id }
    assert_redirected_to page_image_path(assigns(:page_image))
  end

  test "should destroy page_image" do
    assert_difference('PageImage.count', -1) do
      delete :destroy, id: @page_image
    end

    assert_redirected_to page_images_path
  end
end
