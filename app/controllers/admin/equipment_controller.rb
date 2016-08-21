class Admin::EquipmentController < ApplicationController
  before_action :login_required
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  include AdminUtil
  before_action :admin_login_required
  
  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all
    @new_equipment = Equipment.new
    @search_form = SearchForm.new(params[:search_form])
    @equipment = @equipment.search(@search_form.q) if  @search_form.q.present?
    #   respond_to do |format|
    #     format.html #index.html.erb
    #     format.json { render :index }
    #   end
  end

  def show
  end

  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      status = 'success'
      html = render_to_string partial: 'show',
        locals: { equipment: @equipment }
    else
      status = 'error'
    end
    render json: { status: status, data: @equipment, html:html }

    #   respond_to do |format|
    #     if @equipment.save
    #       format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
    #       format.json { render :show, status: :created, location: @equipment }
    #     else
    #       format.html { render :new }
    #       format.json { render json: @equipment.errors, status: :unprocessable_entity }
    #     end
    #   end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update(equipment_params)
      status = 'success'
    else
      status = 'error'
    end
    render json: {status: status ,data: @equipment }
    #  respond_to do |format|
    #     if @equipment.update(equipment_params)
    #       format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
    #       format.json { render :show, status: :ok, location: @equipment }
    #     else
    #       format.html { render :edit }
    #       format.json { render json: @equipment.errors, status: :unprocessable_entity }
    #     end
    #   end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    render json: {status: 'success' ,data: @equipment }
    #  respond_to do |format|
    #    format.html { redirect_to equipment_index_url, notice: 'Equipment was successfully destroyed.' }
    #    format.json { head :no_content }
    #  end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_equipment
    @equipment = Equipment.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def equipment_params
    params.require(:equipment).permit(:name)
  end
end
