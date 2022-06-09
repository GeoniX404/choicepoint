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
    # raise
    @choice_point = ChoicePoint.new(choice_point_params)
    @choice_point.user = current_user
    if @choice_point.save
      redirect_to new_choice_point_option_path(@choice_point)
    else
      render "choice_points/new"
    end
  end

  def vote
    @option = Option.find(params[:choice_point][:option])
    @vote = Vote.new
    @vote.user = current_user
    @vote.option = @option
    if @vote.save
      @option.increase_score(@vote)
      @choice_point = ChoicePoint.find(params[:id])
      redirect_to choice_point_path(@choice_point)
    else
      # I don't think this will work
      render :show
    end
  end

  private

  def choice_point_params
    params.require(:choice_point).permit(:title, :description, :deadline)
  end
end
