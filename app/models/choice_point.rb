class ChoicePoint < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :votes, through: :options
  accepts_nested_attributes_for :options
  validates :title, presence: true
  validates :deadline, presence: true
  acts_as_favoritable

  scope :created_by, ->(user) { where(user: user) }
  scope :not_created_by, ->(user) { where.not(user: user) }
  scope :expires_on_or_after, ->(date) { where(deadline: date...) }
  scope :expires_before, ->(date) { where(deadline: ...date) }
  scope :vote_from, lambda { |user|
    where(id: Vote.joins(:option)
                  .select("options.choice_point_id")
                  .where(user: user))
  }
  scope :no_vote_from, lambda { |user|
    where.not(id: Vote.joins(:option)
                      .select("options.choice_point_id")
                      .where(user: user))
  }

  pg_search_scope :search_by_title_and_description_and_user,
                  against: %i[title description],
                  associated_against: { user: [:name] },
                  using: { tsearch: { prefix: true } }

  def favorited_by?(user)
    user ? super(user) : false
  end

  # Returns true if user has voted on the choice point, false otherwise.
  def vote_from?(user)
    self.class.vote_from(user).where(id: self).size.positive?
  end

  # Gets the total number of votes for a choice point
  def total_votes
    options.reduce(0) do |tally, option|
      tally + option.votes.count
    end
  end

  # Returns the actual score of the leading option.
  def highest_score
    leader&.score
  end

  # Searches through a choice point's options, returns the one with the
  # highest score.
  def leader
    options.reduce do |best, current|
      current.score > best.score ? current : best
    end
  end

  # Returns true if the choice point has expired, false otherwise.
  def expired?
    deadline < Date.today
  end

  def ongoing
    deadline >= Date.today
  end

  def chosen
    options.find(&:chosen)
  end
end
