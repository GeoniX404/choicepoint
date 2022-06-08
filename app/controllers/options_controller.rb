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

  private

  def option_params
    params.require(:option).permit(:description, :pros, :cons)
  end

end
