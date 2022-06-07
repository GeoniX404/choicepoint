class ChoicePoint < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
end
