class PageImagesController < InheritedResources::Base

  private

    def page_image_params
      params.require(:page_image).permit(:page_id, :data, :content_type)
    end
end

