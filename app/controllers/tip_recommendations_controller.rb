class TipRecommendationsController < InheritedResources::Base

  private

    def tip_recommendation_params
      params.require(:tip_recommendation).permit(:name, :rate)
    end
end

