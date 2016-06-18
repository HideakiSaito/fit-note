class TrainingsController < ApplicationController
  before_action :login_required
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  # GET /trainings
  # GET /trainings.json
  def index
    @trainings = Training.default_order
    #@items = Item.all.sample 3  # yuta teacher
    ##全身バランスよく鍛えるように！これならいいね
    @items = [] #初期化はいるな。nil << はできないから。
    @items << Item.on_chest.sample
    @items << Item.on_backs.sample
    @items << Item.on_legs.sample

    require "sparql/client"
    client = SPARQL::Client.new("http://ja.dbpedia.org/sparql")
    results = client.query("
      SELECT DISTINCT ?label ?comment 
      WHERE {
      ?s dcterms:subject  <http://ja.dbpedia.org/resource/Category:トレーニング法>; 
      rdfs:label ?label .
      ?s rdfs:comment ?comment .
             }
       ")
    @sparql_data = results 

  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
  end

  # GET /trainings/new
  def new
      @training = Training.new :num => Training.get_now_num
  end

  # GET /trainings/1/edit
  def edit
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(training_params)

    respond_to do |format|
      if @training.save
        format.html { redirect_to @training, notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to @training, notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:item_id, :weight, :reps, :set, :mode_id, :day, :num)
    end
end
