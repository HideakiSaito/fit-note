class TipCategoriesController < InheritedResources::Base

  private

    def tip_category_params
      params.require(:tip_category).permit(:name)
    end
end

