class LinesController < InheritedResources::Base
  before_action :login_required
  before_action :form_setup ,only:[:new, :edit]

  def index
    @lines = Line.all.order("page_id desc,no asc")
    respond_to do |format|
      format.html #default template
      format.js   #default template
      format.json  #jsonは全部 とりあえずデフォルトでいい
    end
  end

  def form_setup
      #いいねしitemだけ
      @items = current_user.voted_items.order(:part_id, :equipment_id)
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
    @last2_line = nil
    @last3_line = nil
    if current_user != @line.page.user
      redirect_to @line.page, notice: "編集権限のないトレーニング情報です。"
    end
  end

  def edit
    #編集時は全てにしないと。itemだけ
    @items = Item.order(:part_id, :equipment_id)
    @line = Line.find(params[:id])
    #前後のlineへナビゲーション用
    if @line.no != nil
      @next_line = Line.where("page_id = '#{@line.page_id}' and no = #{@line.no + 1}").first
      @prev_line = Line.where("page_id = '#{@line.page_id}' and no = #{@line.no - 1}").first
      @next_line = @next_line.decorate if @next_line
      @prev_line = @prev_line.decorate if @prev_line
    else
      @next_line = nil
      @prev_line = nil
    end
    #前回のトレーニング取得
    @last_line = @line.get_last_line if @line
    #前々回のトレーニング取得
    @last2_line = @last_line.get_last_line if @last_line
    #前々々回のトレーニング取得
    @last3_line = @last2_line.get_last_line if @last2_line
    if current_user != @line.page.user
      redirect_to @line.page, notice: "編集権限のないトレーニング情報です。"
    end
  end

  # POST /items
  # POST /items.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        #js de tobasu
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
    page = @line.page
    @line.destroy
    respond_to do |format|
      format.html { redirect_to page, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    # fileはtmpに自動で一時保存される
     Line.import(params[:file])
     redirect_to pages_url, notice: "Lineをインポートしました。"
  end

  private

  def line_params
    params.require(:line).permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end
