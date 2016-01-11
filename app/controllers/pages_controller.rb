class PagesController < InheritedResources::Base

  private

    def page_params
      params.require(:page).permit(:date, :place, :start_time, :end_time, :memo, :image)
    end
end

