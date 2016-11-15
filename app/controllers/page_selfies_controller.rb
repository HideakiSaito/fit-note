class PageSelfiesController < InheritedResources::Base

  private

    def page_selfy_params
      params.require(:page_selfy).permit(:page_id, :data, :content_type)
    end
end

