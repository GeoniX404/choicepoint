class Option < ApplicationRecord
  belongs_to :choice_point
  has_many :votes
  validates :description, presence: true
end
