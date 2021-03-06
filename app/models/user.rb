class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :confirmable
  include DeviseTokenAuth::Concerns::User
  has_many :authorships
  has_many :articles, through: :authorships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :profiles
  has_many :roles, through: :profiles, dependent: :destroy
  has_many :media, through: :profiles
  after_create :init

  def init
    self.update(security_level: 0)
    first_name = self.first_name || ''
    last_name = self.last_name || ''
    slug = (first_name + ' ' + last_name).parameterize
    while !User.find_by(slug: slug).nil?
      slug += '-' + ([*('0'..'9')]-%w(0 1 I O)).sample(8).join
    end
    self.update(slug: slug)
  end

  def is_editor?(token, client_id)
    self.valid_token?(token, client_id) && self.security_level > 0
  end

  def is_admin?(token, client_id)
    self.valid_token?(token, client_id) && self.security_level > 1
  end
end
