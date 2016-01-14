class PagesController < InheritedResources::Base

def index
  @pages = Page.all.order("id desc")
end

  private
    def page_params
      params.require(:page).permit(:date, :place, :start_time, :end_time, :memo, :image)
    end
end

