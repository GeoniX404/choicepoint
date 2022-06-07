class ChoicePointsController < ApplicationController
  def index
    @choice_points = ChoicePoint.all
  end

  def show
  end
end
