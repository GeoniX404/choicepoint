class OptionsController < ApplicationController
  def create
    @option = Option.find(params[:id])
    @vote = @option.votes.create
    @vote.user = current_user
    # yet to determine the correct redirect path
    redirect_to choice_points_path(@choice_points)
  end

  # private

  # def vote_params
  #   params.require(:vote).permit(:user_id, :option_id)
  # end
end
