class FeelingsController < InheritedResources::Base
  before_action :login_required

  private

    def feeling_params
      params.require(:feeling).permit(:name, :score, :memo)
    end
end

