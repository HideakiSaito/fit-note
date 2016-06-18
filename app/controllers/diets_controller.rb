class DietsController < InheritedResources::Base
  before_action :login_required

  private

    def diet_params
      params.require(:diet).permit(:name)
    end
end

