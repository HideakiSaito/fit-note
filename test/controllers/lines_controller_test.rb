require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  setup do
    @line = lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line" do
    assert_difference('Line.count') do
      post :create, line: { item_id: @line.item_id, memo_0: @line.memo_0, memo_1: @line.memo_1, memo_2: @line.memo_2, memo_3: @line.memo_3, memo_4: @line.memo_4, memo_5: @line.memo_5, memo_6: @line.memo_6, memo_7: @line.memo_7, memo_8: @line.memo_8, memo_9: @line.memo_9, mode_id: @line.mode_id, no: @line.no, page_id: @line.page_id, reps_0: @line.reps_0, reps_1: @line.reps_1, reps_2: @line.reps_2, reps_3: @line.reps_3, reps_4: @line.reps_4, reps_5: @line.reps_5, reps_6: @line.reps_6, reps_7: @line.reps_7, reps_8: @line.reps_8, reps_9: @line.reps_9, weight_0: @line.weight_0, weight_1: @line.weight_1, weight_2: @line.weight_2, weight_3: @line.weight_3, weight_4: @line.weight_4, weight_5: @line.weight_5, weight_6: @line.weight_6, weight_7: @line.weight_7, weight_8: @line.weight_8, weight_9: @line.weight_9 }
    end

    assert_redirected_to line_path(assigns(:line))
  end

  test "should show line" do
    get :show, id: @line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line
    assert_response :success
  end

  test "should update line" do
    patch :update, id: @line, line: { item_id: @line.item_id, memo_0: @line.memo_0, memo_1: @line.memo_1, memo_2: @line.memo_2, memo_3: @line.memo_3, memo_4: @line.memo_4, memo_5: @line.memo_5, memo_6: @line.memo_6, memo_7: @line.memo_7, memo_8: @line.memo_8, memo_9: @line.memo_9, mode_id: @line.mode_id, no: @line.no, page_id: @line.page_id, reps_0: @line.reps_0, reps_1: @line.reps_1, reps_2: @line.reps_2, reps_3: @line.reps_3, reps_4: @line.reps_4, reps_5: @line.reps_5, reps_6: @line.reps_6, reps_7: @line.reps_7, reps_8: @line.reps_8, reps_9: @line.reps_9, weight_0: @line.weight_0, weight_1: @line.weight_1, weight_2: @line.weight_2, weight_3: @line.weight_3, weight_4: @line.weight_4, weight_5: @line.weight_5, weight_6: @line.weight_6, weight_7: @line.weight_7, weight_8: @line.weight_8, weight_9: @line.weight_9 }
    assert_redirected_to line_path(assigns(:line))
  end

  test "should destroy line" do
    assert_difference('Line.count', -1) do
      delete :destroy, id: @line
    end

    assert_redirected_to lines_path
  end
end
