class Option < ApplicationRecord
  belongs_to :choice_point
  has_many :votes
  has_many :users, through: :votes
  validates :description, presence: true
  def increase_score(vote)
    update!(score: score + vote.user.reputation)
  end
end
