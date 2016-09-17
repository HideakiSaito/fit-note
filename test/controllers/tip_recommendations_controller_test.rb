require 'test_helper'

class TipRecommendationsControllerTest < ActionController::TestCase
  setup do
    @tip_recommendation = tip_recommendations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tip_recommendations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tip_recommendation" do
    assert_difference('TipRecommendation.count') do
      post :create, tip_recommendation: { name: @tip_recommendation.name, rate: @tip_recommendation.rate }
    end

    assert_redirected_to tip_recommendation_path(assigns(:tip_recommendation))
  end

  test "should show tip_recommendation" do
    get :show, id: @tip_recommendation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tip_recommendation
    assert_response :success
  end

  test "should update tip_recommendation" do
    patch :update, id: @tip_recommendation, tip_recommendation: { name: @tip_recommendation.name, rate: @tip_recommendation.rate }
    assert_redirected_to tip_recommendation_path(assigns(:tip_recommendation))
  end

  test "should destroy tip_recommendation" do
    assert_difference('TipRecommendation.count', -1) do
      delete :destroy, id: @tip_recommendation
    end

    assert_redirected_to tip_recommendations_path
  end
end
