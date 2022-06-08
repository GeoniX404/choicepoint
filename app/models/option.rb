class Option < ApplicationRecord
  belongs_to :choice_point
  has_many :votes
  has_many :users, through: :votes
  validates :description, presence: true
end
