class PagesController < InheritedResources::Base

  def index
    @pages = Page.order("id desc")
    .paginate(page: params[:page], per_page: 3)
  end

  def create

    
    create!

#     super

#    @page = Page.new(page_params)
#
#    respond_to do |format|
#      if @page.save
#        format.html { redirect_to @page, notice: 'Page was successfully created.' }
#        format.json { render :show, status: :created, location: @page }
#      else
#        format.html { render :new }
#        format.json { render json: @page.errors, status: :unprocessable_entity }
#      end
#    end
#
  end

  def update

    @page = Page.find(params[:id])
    @page.assign_attributes(page_params)

    @new_lines = nil
    #ここで、コピーするなら過去の、トレーニングを取得する
    if  params[:page_copy] = 1
      @copy_lines = Page.find(params[:copy_page][:id]).lines
      @new_lines = @copy_lines.map do |copy_line| 
        new_line = Line.new(item_id: copy_line.item_id,
                           mode_id: copy_line.mode_id,
                           weight_1: copy_line.weight_1,
                           weight_2: copy_line.weight_2
                           )
        new_line.save
        @page.lines << new_line
      end
    end

    respond_to do |format|
      if @page.save
        message = 'Page was successfully updated.'
        unless @new_lines.empty?
         message += 'Copy Lines!!!'
        end
        format.html { redirect_to @page,
                      notice: message }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def page_params
    params.require(:page).permit(:date, :place, :start_time, :end_time, :memo, :image)
  end


    def copy_line_params copy_line
      copy_line.permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
    end
end

