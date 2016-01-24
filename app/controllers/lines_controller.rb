class LinesController < InheritedResources::Base

  def new
    # @training = Training.new :num => Training.get_now_num
    @line = Line.new :no => 1 , :mode_id => 1
    if params[:page_id]
      @line.page_id = params[:page_id]  
    end
  end


  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      @line = Line.find(params[:id])
      if @line.update(line_params)
        format.html { redirect_to :pages, notice: 'Item was successfully updated.' }
        # フォーマットがjsの時の処理。
        #       # @statusに”success”を代入してjsファイルに渡している。
        format.js { @status = 'success' }
        format.json { render :show, status: :ok, location: @line }
      else
        format.html { render :edit }

        # フォーマットがjsの時の処理
        #       # @statusに”fail”を代入してjsファイルに渡している。
        format.js { @status = 'fail' }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def line_params
    params.require(:line).permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end

