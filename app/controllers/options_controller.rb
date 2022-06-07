class OptionsController < ApplicationController
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
end
