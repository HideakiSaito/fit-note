class DietsController < InheritedResources::Base

  private

    def diet_params
      params.require(:diet).permit(:name)
    end
end

