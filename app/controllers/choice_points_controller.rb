class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new show create]

  def index
    if params[:query].present?
      @choice_points = ChoicePoint.search_by_title_and_description(params[:query])
    else
    @choice_points = ChoicePoint.all
    end
  end

  def show
    @choice_point = ChoicePoint.find(params[:id])
  end

  def new
    @choice_point = ChoicePoint.new
    # @choice_point.options.build
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
end
