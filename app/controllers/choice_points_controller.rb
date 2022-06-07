class ChoicePointsController < ApplicationController
skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @choice_points = ChoicePoint.all
  end

  def show
  end
end
