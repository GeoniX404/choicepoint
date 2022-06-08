class OptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new create]

  def index
    @options = Option.all
  end

  def new
    @option = Option.new
    @choice_point = ChoicePoint.find(params[:choice_point_id])
    @option.choice_point = @choice_point
  end

  def create
    @choice_point = ChoicePoint.find(params[:choice_point_id])
    @option = Option.new
    @option.user = current_user
    @option.choice_point = @choice_point

    if @option.save
      redirect_to choice_point_path(@choice_point)
    else
      render 'choice_points'
    end
  end

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

  private

  def option_params
    params.require(:option).permit(:description, :pros, :cons)
  end
