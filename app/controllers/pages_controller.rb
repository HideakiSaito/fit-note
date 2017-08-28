class PagesController < InheritedResources::Base
  before_action :login_required
  before_action :form_setup ,only:[:new, :edit]
  before_action :growl_setup ,only:[:show]

  include ChartUtil
  def show_pic
    params[:start_day] ||= Date.current - 30		
    params[:end_day] ||= Date.current		
    params[:scope] ||= "all"
    self.index_logic "all" ,false
    @simple_page = false
    @show_detail = false
    @show_chart = false
    render :index
  end
  def training_only
    params[:start_day] ||= Date.current - 30		
    params[:end_day] ||= Date.current		
    params[:scope] ||= "gym"
    self.index_logic "training_only",false
    @simple_page = false
    @show_detail = true
    @show_chart = false
    render :index
  end
  def selfy_only
    params[:start_day] ||= Date.current - 365
    params[:end_day] ||= Date.current
    params[:scope] ||= "startend"
    self.index_logic "selfy_only",false
    @selfy_only = true
    @simple_page = false
    @show_detail = false 
    @show_chart = false
    render :index
  end
  def index
    params[:start_day] ||= Date.current - 30		
    params[:end_day] ||= Date.current		
    params[:scope] ||= "all"
    @simple_page = true
    @show_detail = false
    @show_chart = false
    self.index_logic "all"
    respond_to do |format|
      format.html #default template
      format.js   #default template ajax
      format.json { @pages = Page.order("date desc") } #jsonは全部
    end
  end
  def show_index_init
    @chart_pie_parts_index = {}
    @chart_pie_diets_index = {}
    @chart_healths_index = {}
    @chart_waters_index = {}
  end
  def daily_chart page
    @chart_pie_parts_index[page.id] = day_training_chart(page)
    @chart_pie_diets_index[page.id] = day_diet_chart(page)
    @chart_healths_index[page.id] = day_health_chart(page)
    @chart_waters_index[page.id] = day_water_chart(page)
  end
  def index_logic disp_mode , disp_other = true
    @disp_mode = disp_mode
    @disp_other_is = disp_other
    @show = false
    @page_class = "col-xs-12 col-sm-12 col-md-6 col-lg-6"
    if @simple_page
#      @pages = Page.default_cal
       @pages = Page.includes(:diet).includes(:feeling).includes(:condition).order("date")
    else
      @pages = Page.default
    end
    x_user = params[:user_id]? params[:user_id] : current_user
    @pages = @pages.where("user_id=?", x_user) #user
    @pages = @pages.training_only if disp_mode == "training_only"
    @pages = @pages.selfy_only if disp_mode == "selfy_only"
    #search
    params[:start_day] ||= Date.current - 30*9
    params[:end_day] ||= Date.current
    params[:scope] ||= "startend"
    start_day = params[:start_day] 
    end_day = params[:end_day] 
    where = "date >= '#{start_day}' and date <= '#{end_day}' "
    where += " and place like 'ジム' " if params[:scope] == "gym"		
    where += " and place like '家' " if params[:scope] == "home"
    @pages = @pages.where(where) 
    if params[:scope] == "startend"
      temp = @pages
      pages = []
      pages << temp.first 
      pages << temp.last
      @pages = pages
    else
      @pages = @pages.paginate(page: params[:page], per_page: 15) 
    end
    #simple_page
    @simple_page ||= true
    @selfy_only ||= false
    self.show_index_init
    @pages.each do |page|
      self.daily_chart page
    end
#    @pages = PageDecorator.decorate_collection(@pages)
  end
  def show
    @show = true
    @disp_mode = "show"
    @disp_other_is = true
    @page_class = ""
    @page = Page.find(params[:id])
    self.show_index_init
    self.daily_chart @page
    @page = PageDecorator.decorate(@page)
    @prev_page = Page.where("date < ? ",@page.date).order("date desc").first 
    @next_page = Page.where("date > ? ",@page.date).order("date asc").first 
    #画像対応
    if params[:format].in?(["jpg", "png", "gif"])
      if params[:sefly]
        send_selfy
      else
        send_image
      end
    else
      render "show"
    end
  end

  def form_setup
      #いいねした食品だけ、かつ最後に食べたものが上にくるように
      @foods = current_user.voted_foods.order_last_meal
  end

  def new
    #トレーニンぐ時間、睡眠時間の初期値をセット
    @page = Page.new(
      end_time: Time.current + (2.5 * 60 * 60),
      sleep_time: Time.local(2000, 1, 1, 22, 30, 00) ,
      sleep_hour: 7.5)
    #一番直近の同じ曜日の健康データをセットする
    last_wday = Page.where("extract(dow from date) = ?",Time.current.wday).order("date desc").first
    if last_wday
      @page.place = last_wday.place
      @page.start_time = last_wday.start_time #トレーニングも定期的だろうから
      @page.end_time = last_wday.end_time
      @page.training_hour = last_wday.training_hour
      @page.diet_id = last_wday.diet_id
      @page.water = last_wday.water #日常の数値
      @page.alcohol = last_wday.alcohol
      @page.caffeine = last_wday.caffeine
      @page.work_hour = last_wday.work_hour
      @page.tv_hour = last_wday.tv_hour
      @page.study_hour = last_wday.study_hour
    end
    @page = PageDecorator.decorate(@page)
    @page.build_image unless @page.image
    @page.build_selfy unless @page.selfy
  end

  def edit
    @page = Page.find(params[:id])
    @page = PageDecorator.decorate(@page)
    @page.build_image unless @page.image
    @page.build_selfy unless @page.selfy
    if current_user != @page.user
      redirect_to @page, notice: "編集権限のないページです。"
    end
  end

  def create
    @page = Page.new(page_params)
    @page.user = current_user #ユーザ情報と紐付ける
    @new_lines = nil
    respond_to do |format|
      if @page.save
        copy_page_lines
        @page.save
        last_meals_save
        message = 'Page was successfully updated.'
        message += 'Copy Lines!!!' if  @new_lines
        format.html { redirect_to @page, method: :get,
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
        last_meals_save
        message = 'Page was successfully updated.'
        message += 'Copy Lines!!!' if @new_lines
        format.html { redirect_to @page,
                      notice: message }
      else
        format.html { render :edit }
      end
    end
  end
  
  # 食事メニューから選択した食事を最後に食べた食事モデルに保存する
  def last_meals_save
    if meals = params[:last_meals].split(",")
      meals.each do |food_id|
        meal = LastMeal.where("user_id = ? and food_id = ? ",current_user.id,food_id).first
        if meal
          #Update
          meal.date = Date.current
          meal.save
        else
          #Insert
          food = Food.find food_id
          meal = LastMeal.new(user: current_user,food: food,date: Date.current)
          meal.save
        end
      end
    end   
  end  
  
  def import
    Page.import(params[:file]) # fileはtmpに自動で一時保存される
    redirect_to pages_url, notice: "Pageをインポートしました。"
  end

  private
  def growl_setup
    @tip = Tip.random_one
  end
  # 画像送信
  def send_image
    if @page.image.present?
      send_data @page.image.data,
        type: @page.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
  def send_selfy
    if @page.selfy.present?
      send_data @page.selfy.data,
        type: @page.selfy.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
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
                           weight_5: copy_line.weight_5,
                           weight_6: copy_line.weight_6,
                           weight_7: copy_line.weight_7,
                           weight_8: copy_line.weight_8,
                           weight_9: copy_line.weight_9,
                           weight_0: copy_line.weight_0
                          )
                          0
      end
    end
  end

  def page_params

    attrs = [:user_id,:date, :place, :start_time, :end_time, :memo, :diet_id ,:carbohydrate_1,:fat_1,:protein_1, :vegetable_1, :diet_memo_1,:carbohydrate_2,:fat_2,:protein_2, :vegetable_2, :diet_memo_2,:carbohydrate_3,:fat_3,:protein_3, :vegetable_3, :diet_memo_3,:carbohydrate_4,:fat_4,:protein_4, :vegetable_4, :diet_memo_4,:carbohydrate_5,:fat_5,:protein_5, :vegetable_5, :diet_memo_5 ,:condition_id ,:feeling_id ,:sleep_hour ,:sleep_time ,:water ,:alcohol ,:caffeine ,:wight ,:work_hour ,:study_hour ,:tv_hour,:training_hour ,:body_fat_per,:body_size_neck,:body_size_bust,:body_size_waist,:body_size_hip,:body_size_arm_right,:body_size_arm_left,:body_size_leg_right,:body_size_leg_left,:body_size_calf_right,:body_size_calf_left]
    attrs << { image_attributes: [:_destroy, :id, :uploaded_image] }
    attrs << { selfy_attributes: [:_destroy, :id, :uploaded_image] }
    params.require(:page).permit(attrs)
  end

  def copy_line_params copy_line
    copy_line.permit(:page_id, :no, :item_id, :mode_id, :weight_1, :reps_1, :memo_1, :weight_2, :reps_2, :memo_2, :weight_3, :reps_3, :memo_3, :weight_4, :reps_4, :memo_4, :weight_5, :reps_5, :memo_5, :weight_6, :reps_6, :memo_6, :weight_7, :reps_7, :memo_7, :weight_8, :reps_8, :memo_8, :weight_9, :reps_9, :memo_9, :weight_0, :reps_0, :memo_0)
  end
end
