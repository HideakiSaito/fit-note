class ItemsController < ApplicationController
  include ChartUtil
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.order(:part_id, :equipment_id)
    
  end

  def search
    @items = Item.search(params[:q])
    render "index"
  end
  
  # GET /items/1
  # GET /items/1.json
  def show
    analysis_initialize("ジム") #ChartUtil
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: @item.name + 'トレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: @item.name , data: chart_data(@item.id))
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    # fileはtmpに自動で一時保存される
     Item.import(params[:file])
     redirect_to items_url, notice: "Itemをインポートしました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :reps, :part_id, :mode_id, :equipment_id)
    end
end
