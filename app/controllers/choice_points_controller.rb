class ChoicePointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new show create toggle_favorite]
  decorates_assigned :choice_point, :choice_points

  def index
    @choice_points = ChoicePoint.expires_on_or_after(Date.today)
                                .order(id: :desc)
    @last_chance_choice_points = last_chance(@choice_points)
    @choice_points = filter(@choice_points) if params[:query].present?
    @choice_points.includes!(:user, :voters, favorited: [:favoritor])
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render_card_partial }
    end
  end

  def toggle_favorite
    @choice_point = ChoicePoint.find(params[:id])
    current_user.favorited?(@choice_point) ? current_user.unfavorite(@choice_point) : current_user.favorite(@choice_point)
  end

  def show
    @choice_point = ChoicePoint.find(params[:id])
    @options = @choice_point.options.order(:id)
    @options_by_score = @options.reorder(score: :desc)
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
    # Increase score of chosen option
    @option = Option.find(params[:choice_point][:option])
    @vote = Vote.create(user: current_user, option: @option)
    @option.increase_score(@vote)

    # Rerender choice point
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
                         options: @choice_point.options.order(:id) },
               formats: [:html]
      end
    end
  end

  def update
    @choice_point = ChoicePoint.find(params[:id])
    @chosen_option = Option.find(params[:choice_point][:chosen])
    save_chosen_option(@chosen_option)
    save_success_status(@choice_point)
    boost_reputation(@chosen_option) if @choice_point.successful
    render_feedback(@choice_point)
  end

  def my_choice_points
    choice_points = ChoicePoint.where(user: current_user)
    @expired, @ongoing = choice_points.partition(&:expired?)
    @favorites = current_user.all_favorites
  end

  private

  def choice_point_params
    params.require(:choice_point).permit(:title, :description, :deadline)
  end

  def filter(choice_points)
    choice_points.search_by_title_and_description_and_user(params[:query])
  end

  def last_chance(choice_points)
    choice_points.expires_on_or_after(Date.today)
                 .not_created_by(current_user)
                 .no_vote_from(current_user)
                 .reorder(deadline: :asc)
                 .limit(5).decorate
  end

  def render_card_partial
    render partial: 'card',
           collection: choice_points.map(&:card),
           formats: [:html]
  end

  def save_chosen_option(chosen_option)
    chosen_option.chosen = true
    chosen_option.save
  end

  def save_success_status(choice_point)
    case params[:choice_point][:successful]
    when 'true' then choice_point.successful = true
    when 'false' then choice_point.successful = false
    end
    choice_point.feedback = "Feedback Provided"
    choice_point.save
  end

  def boost_reputation(chosen_option)
    chosen_option.voters.each do |user|
      user.update(reputation: user.reputation + 5)
    end
  end

  def render_feedback(choice_point)
    respond_to do |format|
      format.html do
        redirect_to my_choice_points_path
      end
      format.text do
        render partial: 'completed_feedback',
               locals: { choice_point: choice_point },
               formats: [:html]
      end
    end
  end
end
