class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new show create toggle_favorite]
  decorates_assigned :choice_point, :choice_points

  def index
    @choice_points = ChoicePoint.expires_on_or_after(Date.today)
                                .order(id: :desc)
    @choice_points = filtered_choice_points if params[:query].present?
    @choice_points.includes!(:user)
    @last_chance_choice_points = last_chance_choice_points
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render_card_partial }
    end
  end

  def toggle_favorite
    @choicepoint = ChoicePoint.find(params[:id])
    current_user.favorited?(@choicepoint) ? current_user.unfavorite(@choicepoint) : current_user.favorite(@choicepoint)
  end

  def show
    @choice_point = ChoicePoint.find(params[:id])
    @expired = @choice_point.expired?
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
                         expired: @choice_point.expired?,
                         belongs_to_current_user: false },
               formats: [:html]
      end
    end
  end

  def update
    @choice_point = ChoicePoint.find(params[:id])
    @chosen_option = Option.find(params[:choice_point][:chosen_option][:id])
    @chosen_option.chosen = true
    @chosen_option.save
    if params[:choice_point][:successful] == "true"
      @choice_point.successful = true
    elsif params[:choice_point][:successful] == "false"
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
    respond_to do |format|
      format.html do
        redirect_to my_choice_points_path
      end
      format.text do
        render partial: "choice_points/feedback/completed",
               locals: { choice_point: @choice_point },
               formats: [:html]
      end
    end
  end

  def my_choice_points
    @choice_points = ChoicePoint.all
    @belongs_to_current_user = @choice_points.where(user: current_user)
    @ongoing = @belongs_to_current_user.filter do |point|
      point.ongoing
    end
    @belongs_to_current_user_expired = @choice_points.where(user: current_user)
    @expired = @belongs_to_current_user.filter do |point|
      point.expired?
    end
  end

  private

  def choice_point_params
    params.require(:choice_point).permit(:title, :description, :deadline)
  end

  def filtered_choice_points
    @choice_points.search_by_title_and_description_and_user(params[:query])
  end

  def last_chance_choice_points
    ChoicePoint.expires_on_or_after(Date.today)
               .not_created_by(current_user)
               .no_vote_from(current_user)
               .order(deadline: :asc)
               .limit(5).decorate
  end

  def render_card_partial
    render partial: 'card',
           collection: choice_points.map(&:card),
           formats: [:html]
  end
end
