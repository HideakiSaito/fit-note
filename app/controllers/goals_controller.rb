class GoalsController < InheritedResources::Base
  before_action :login_required

  private

    def goal_params
      params.require(:goal).permit(:user_id, :start_date, :end_date, :memo, :push_val1, :push_val2, :pull_val1, :pull_val2, :leg_val1, :leg_val2, :back_val1, :back_val2, :protein_val1, :protein_val2, :carbohydrate_val1, :carbohydrate_val2, :fat_val1, :fat_val2, :vegetable_val1, :vegetable_val2, :weight_val1, :fat_per_val1, :body_size_neck, :body_size_bust, :body_size_waist, :body_size_hip, :body_size_arm, :body_size_leg_right, :body_size_calf_right)
    end
end

