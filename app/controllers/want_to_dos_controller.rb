class WantToDosController < InheritedResources::Base

  private

    def want_to_do_params
      params.require(:want_to_do).permit(:user_id, :estimate, :title, :description, :category, :status, :done)
    end
end

