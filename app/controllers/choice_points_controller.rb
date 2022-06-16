class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new show create toggle_favourite]

  def index
    if params[:query].present?
      @choice_points = ChoicePoint.search_by_title_and_description_and_user(params[:query])
    else
      @choice_points = ChoicePoint.all.order(deadline: :desc)
    end

    @last_chance = ChoicePoint.all.order(deadline: :asc).select{|choicepoint| choicepoint.deadline > Date.today}.take(5)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'choice_points/list', locals: { choice_points: @choice_points }, formats: [:html] }
    end
  end

  def toggle_favorite
    @choicepoint = ChoicePoint.find(params[:id])
    current_user.favorited?(@choicepoint) ? current_user.unfavorite(@choicepoint) : current_user.favorite(@choicepoint)
  end

  def show
    @choice_point = ChoicePoint.find(params[:id])
    @expired = @choice_point.expired
    @user_has_voted = @choice_point.vote_from?(current_user)
    @highest_score = @choice_point.highest_score
    @belongs_to_current_user = @choice_point.user == current_user
    if @belongs_to_current_user
      @user_string = 'You asked…'
    else
      @user_string = "#{@choice_point.user.name} asks…"
    end
    @title = @choice_point.title

    @options = Option.all
    @choice_point_options = @options.where(choice_point_id: @choice_point[:id])
    @descriptions = @choice_point_options.map(&:description)
  end

  def new
    @choice_point = ChoicePoint.new
    # @choice_point.options.build
  end

  def create
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
    @vote.save!
    @option.increase_score(@vote)
    @choice_point = ChoicePoint.find(params[:id])
    respond_to do |format|
      format.html do
        redirect_to choice_point_path(@choice_point)
      end
      format.text do
        render partial: "choice_points/results",
               locals: { choice_point: @choice_point,
                         highest_score: @choice_point.highest_score,
                         expired: @choice_point.expired },
               formats: [:html]
      end
    end
  end

  def update
    @choice_point = ChoicePoint.find(params[:id])
    @chosen_option = Option.find(params[:choice_point][:chosen_option][:id])
    @chosen_option.chosen = true
    @chosen_option.save
    if params[:choice_point][:successful] == "1"
      @choice_point.successful = true
    elsif params[:choice_point][:successful] == "0"
      @choice_point.successful = false
    end
    @choice_point.feedback = "Feedback Provided"
    @choice_point.save
    @chosen_users = @chosen_option.users
    if @choice_point.successful
      @chosen_users.each do |user|
        user.update(reputation: user.reputation + 5)
      end
    end
    redirect_to choice_point_path(@choice_point)
    # if @belongs_to_current_user && @expired
    #   # render feedback form asks user to select chosen option (sets option chosen to true)
    #   # successful or not (adds true or false to ChoicePoint.success)
    #   # and in turn adjusts voter rep accordingly
    # end
  end

    # if @belongs_to_current_user && @expired
    #   redirect_to choice_points(@belongs_to_current_user)
    # else
    #   render "choice_points/new"
    # end

  def my_choice_points
    @choice_points = ChoicePoint.all
    @belongs_to_current_user = @choice_points.where(user: current_user)
    @ongoing = @belongs_to_current_user.filter do |point|
      point.ongoing
    end
    @belongs_to_current_user_expired = @choice_points.where(user: current_user)
    @expired = @belongs_to_current_user.filter do |point|
      point.expired
    end
  end

  private

  def choice_point_params
    params.require(:choice_point).permit(:title, :description, :deadline)
  end
end
