class ConditionsController < InheritedResources::Base

  private

    def condition_params
      params.require(:condition).permit(:name, :score, :memo)
    end
end

