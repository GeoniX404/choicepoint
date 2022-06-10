class ChoicePoint < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  pg_search_scope :search_by_title_and_description,
    against: %i[ title description ],
    using: {
      tsearch: { prefix: true }
    }

  def vote_from?(user)
    # Not very efficient: Could be improved via techniques from Advanced DB lecture?
    options.any? do |option|
      option.votes.any? do |vote|
        vote.user == user
      end
    end
  end

  def highest_score
    leader&.score
  end

  def leader
    options.reduce do |best, current|
      current.score > best.score ? current : best
    end
  end
end
