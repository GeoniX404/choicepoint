class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def show
    @choice_point = ChoicePoint.find(params[:id])
  end
end
