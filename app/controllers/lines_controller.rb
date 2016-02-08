class LinesController < InheritedResources::Base

  def index
    @lines = Line.all.order("page_id desc,no asc")
    respond_to do |format|
      format.html #default template
      format.js   #default template
      format.json  #jsonは全部 とりあえずデフォルトでいい
    end
  end

  def new
    # @training = Training.new :num => Training.get_now_num
    now_no = Line.get_now_no(params[:page_id])
    @line = Line.new :no => now_no , :mode_id => 1
    if params[:page_id]
      @line.page_id = params[:page_id]  
    end
    @next_line = nil
    @prev_line = nil
    @last_line = nil
  end

  def edit
    @line = Line.find(params[:id])
    #前後のlineへナビゲーション用
    if @line.no != nil
      @next_line = Line.where("page_id = '#{@line.page_id}' and no = #{@line.no + 1}").first
      @prev_line = Line.where("page_id = '#{@line.page_id}' and no = #{@line.no - 1}").first
    else
      @next_line = nil
      @prev_line = nil
    end
    #前回のトレーニング取得
    @last_line = @line.get_last_line
  end

  # POST /items
  # POST /items.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.js { @status = 'success' }
      else
        format.js { @status = 'fail' }
      end
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

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @line = Line.find(params[:id])
    @line.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    render text: params[:file] 
  end

  private

  def line_params
    params.require(:line).permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end

