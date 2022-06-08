class Option < ApplicationRecord
  belongs_to :choice_point
  has_many :votes
  has_many :users, through: :votes
  validates :description, presence: true

  # def options_attributes=(options_attributes)
  #   options_attributes.each do |i, option_attributes|
  #     if option_attributes[:description].length > 0 && option_attributes[:pros].length > 0 && option_attributes[:cons].length > 0
  #     self.options.build(option_attributes)
  #     end
  #   end
  # end
end
