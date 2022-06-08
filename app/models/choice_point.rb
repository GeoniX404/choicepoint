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
end
