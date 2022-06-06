class ChoicePoint < ApplicationRecord
  belongs_to :user
  has_many :options
  has_many :tags
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
end
