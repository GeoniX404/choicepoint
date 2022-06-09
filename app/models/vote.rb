class Vote < ApplicationRecord
  belongs_to :option
  belongs_to :user
  belongs_to :choice_point

  scope :popular, -> { select('id, count(id) as count').group(:id).order('count desc').limit(10) }
end
