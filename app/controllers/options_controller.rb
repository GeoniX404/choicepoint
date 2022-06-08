class OptionsController < ApplicationController
  def vote
    @option = Option.find(params[:id])
    @vote = @option.votes.create
    @vote.user = current_user
    # yet to determine if this the correct redirect path for votes
    redirect_to choice_point_options_path(@option)
  end

  # private

  # def vote_params
  #   params.require(:vote).permit(:user_id, :option_id)
  # end
end
