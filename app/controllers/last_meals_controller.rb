class LastMealsController < InheritedResources::Base

  private

    def last_meal_params
      params.require(:last_meal).permit(:user_id, :food_id, :date, :memo)
    end
end

