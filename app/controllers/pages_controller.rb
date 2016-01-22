class PagesController < InheritedResources::Base

  def index
    @pages = Page.all.order("id desc")
  end

  def create

    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    @page = Page.find(params[:id])
    @page.assign_attributes(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
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
end

