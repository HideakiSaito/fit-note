class PagesController < InheritedResources::Base
  include ChartUtil
  def hidden_training
    self.index_logic "hidden_training"
  end
  def training_only_note
    self.index_logic "training_only" ,false
  end
  def training_only
    self.index_logic "training_only"
  end
  def index
    self.index_logic "all"
  end
  def index_logic disp_mode , disp_other = true
    @disp_mode = disp_mode
    @disp_other_is = disp_other
    @show = false
    #@page_class = "col-xs-12 col-sm-6 col-md-4 col-lg-4" 
    @page_class = "col-xs-12 col-sm-12 col-md-12 col-lg-12" 
    @search_form = SearchForm.new params[:search_form]
    @pages = Page.includes(:diet).includes(:lines).order("date desc")
    @pages = @pages.training_only if disp_mode == "training_only"
    @pages = @pages.search @search_form.q if @search_form.q.present?
    @pages = @pages.paginate(page: params[:page], per_page: 12)
    @chart_pie_parts_index = {}
    @chart_pie_diets_index = {}
    @pages.each do |page|
      @chart_pie_parts_index[page.id] = day_training_chart(page)
      @chart_pie_diets_index[page.id] = day_diet_chart(page)
    end
    if disp_mode == "all"
      respond_to do |format|
        format.html #default template
        format.js   #default template
        format.json { @pages = Page.order("date desc") } #jsonは全部
      end
    else
     render :index 
    end
  end
  def show
    @show = true
    @disp_mode = "all"
    @disp_other_is = true 
    @page_class = "" 
    @page = Page.find(params[:id])
    @chart_pie_parts_index = {}
    @chart_pie_diets_index = {}
    @chart_pie_parts_index[@page.id] = day_training_chart(@page)
    @chart_pie_diets_index[@page.id] = day_diet_chart(@page)
  end

  def new
    @page = Page.new(
      end_time: Time.current + (2.5 * 60 * 60),
      sleep_time: Time.local(2000, 1, 1, 22, 30, 00) ) 
  end

  def create
    @page = Page.new(page_params)
    @new_lines = nil
    respond_to do |format|
      if @page.save
        copy_page_lines
        @page.save
        message = 'Page was successfully updated.'
        message += 'Copy Lines!!!' if  @new_lines
        format.html { redirect_to pages_path, method: :get,
                      notice: message }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.assign_attributes(page_params)
    copy_page_lines
    respond_to do |format|
      if @page.save
        message = 'Page was successfully updated.'
        message += 'Copy Lines!!!' if @new_lines
        format.html { redirect_to @page,
                      notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  def import
    Page.import(params[:file]) # fileはtmpに自動で一時保存される
    redirect_to pages_url, notice: "Pageをインポートしました。"
  end

  private
  def copy_page_lines
    #ここで、コピーするなら過去の、トレーニングを取得する
    if  params[:copy_page][:id] != "" &&  @page.lines.empty?
      @copy_lines = Page.find(params[:copy_page][:id]).lines
      @new_lines = @copy_lines.map do |copy_line| 
        @page.lines.create(no: copy_line.no,
                           item_id: copy_line.item_id,
                           mode_id: copy_line.mode_id,
                           weight_1: copy_line.weight_1,
                           weight_2: copy_line.weight_2,
                           weight_3: copy_line.weight_3,
                           weight_4: copy_line.weight_4,
                           weight_5: copy_line.weight_5
                          )
      end
    end
  end

  def page_params
    params.require(:page).permit(:date, :place, :start_time, :end_time, :memo, :image,:diet_id ,:carbohydrate_1,:fat_1,:protein_1, :vegetable_1, :diet_memo_1,:carbohydrate_2,:fat_2,:protein_2, :vegetable_2, :diet_memo_2,:carbohydrate_3,:fat_3,:protein_3, :vegetable_3, :diet_memo_3,:carbohydrate_4,:fat_4,:protein_4, :vegetable_4, :diet_memo_4,:carbohydrate_5,:fat_5,:protein_5, :vegetable_5, :diet_memo_5 ,:condition_id ,:feeling_id ,:sleep_hour ,:sleep_time ,:water ,:alcohol ,:caffeine ,:wight ,:work_hour ,:study_hour ,:tv_hour)
  end

  def copy_line_params copy_line
    copy_line.permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end

