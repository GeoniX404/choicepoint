class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :choice_points, dependent: :destroy
  # TODO: Check whether dependent: :destroy is needed here
  has_many :votes, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_favoritor
end
