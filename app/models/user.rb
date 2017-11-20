class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :articles, through: :authorships
  has_many :comments
  has_many :user_roles
  has_many :roles, through: :user_roles
end
