class ChoicePoint < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :votes, through: :options
  accepts_nested_attributes_for :options
  validates :title, presence: true
  validates :deadline, presence: true

  pg_search_scope :search_by_title_and_description_and_user,
    against: %i[ title description ],
    associated_against: {
      user: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }

  def vote_from?(user)
    # Returns true if user has voted on the choice point, false otherwise.

    # NOTE: Not very efficient: Could be improved via techniques from Advanced
    # DB lecture?
    options.any? do |option|
      option.votes.any? do |vote|
        vote.user == user
      end
    end
  end

  def total_votes
    # Gets the total number of votes for a choice point
    options.reduce(0) do |tally, option|
      tally + option.votes.count
    end
  end

  def highest_score
    # Returns the actual score of the leading option.
    leader&.score
  end

  def leader
    # Searches through a choice point's options, returns the one with the
    # highest score.
    options.reduce do |best, current|
      current.score > best.score ? current : best
    end
  end

  def expired
    # Returns true if the choice point has expired, false otherwise.
    # TODO: Should have named this method with a question mark at the end...
    deadline < Date.today
  end

  def ongoing
    deadline >= Date.today
  end

  def chosen
    options.find(&:chosen)
  end
end
