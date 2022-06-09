class OptionsController < ApplicationController

  def new
    @option = Option.new
    @choice_point = ChoicePoint.find(params[:choice_point_id])
    @option.choice_point = @choice_point
  end

  def create
    @choice_point = ChoicePoint.find(params[:choice_point_id])
    @option = Option.new(option_params)
    # @option.user = current_user
    @option.choice_point = @choice_point

    if @option.save
      redirect_to choice_point_path(@choice_point)
    else
      render :new
    end
  end

  # private

  # def vote_params
  #   params.require(:vote).permit(:user_id, :option_id)
  # end

  private

  def option_params
    params.require(:option).permit(:description, :pros, :cons)
  end
end
