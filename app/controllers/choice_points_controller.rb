class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new show create]

  def index
    @choice_points = ChoicePoint.all
  end

  def new
    @choice_point = ChoicePoint.new
  end

  def create
    @choice_point = ChoicePoint.new(choice_point_params)
    @choice_point.user = current_user
    if @choice_point.save
      redirect_to choice_points_path(@choice_point)
    else
      render "choice_points/new"
    end
  end

  private

  def choice_point_params
    params.require(:choice_point).permit(:title, :description, :deadline)
  end

  # def show
  # end
end
