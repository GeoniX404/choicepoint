class Option < ApplicationRecord
  belongs_to :choice_point
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  validates :description, presence: true

  def increase_score(vote)
    update!(score: score + vote.user.reputation)
  end
end
