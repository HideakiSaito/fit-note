class PagesController < InheritedResources::Base
  include ChartUtil
  def index
    @show = false 
    @search_form = SearchForm.new params[:search_form]
    @pages = Page.order("date desc")
    @pages = @pages.search @search_form.q if @search_form.q.present?
    @pages = @pages.paginate(page: params[:page], per_page: 12)
    @chart_pie_parts_index = {}
    @pages.each do |page|
      @chart_pie_parts_index[page.id] = self.day_chart(page.id)
    end
    respond_to do |format|
      format.html #default template
      format.js   #default template
      format.json { @pages = Page.order("date desc") } #jsonは全部
    end
  end

  def day_chart(x_id)
     LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts(x_id) , type: 'pie')
    end
  end

  def show
    @show = true
    @page = Page.find(params[:id])
    @chart_pie_parts_index = {}
    @chart_pie_parts_index[@page.id] = self.day_chart(@page.id)
    @chart_pie_parts = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts(params[:id]) , type: 'pie')
    end
  end

  def new
    @page = Page.new(end_time: Time.current + (2.5 * 60 * 60) ) #だいたい２時間３０分
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
    params.require(:page).permit(:date, :place, :start_time, :end_time, :memo, :image)
  end

  def copy_line_params copy_line
    copy_line.permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end

