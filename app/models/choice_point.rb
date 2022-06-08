class ChoicePoint < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
  # accepts_nested_attributes_for :options

  # def options_attributes=(options_attributes)
  #   options_attributes.each do |i, option_attributes|
  #     self.options.build(option_attributes)
  #   end
  # end
end
