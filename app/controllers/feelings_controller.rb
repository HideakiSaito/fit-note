class FeelingsController < InheritedResources::Base

  private

    def feeling_params
      params.require(:feeling).permit(:name, :score, :memo)
    end
end

