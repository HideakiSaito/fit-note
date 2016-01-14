class LinesController < InheritedResources::Base
  
def new
  @line = Line.new :no => 1 , :mode_id => 1
  if params[:page_id]
   @line.page_id = params[:page_id]  
  end
end
  private

    def line_params
      params.require(:line).permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
    end
end

