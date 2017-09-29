# This User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_many :orders

  attr_accessor :skip_password
  validates :email, format: { with: /\A[^-.]\w+[-.]?(\w+[-!#$%&'*+\/=?^_`{|}~.]\w+)*[^-]@([\w\d]+)\.([\w\d]+)\z/ }
  validates :password, length: { minimum: 8 }, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])[\w-]{8,}/ }, unless: :skip_password


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      auth_info = auth.info
      user.email = auth_info.email
      user.password = Devise.friendly_token[0, 20]
      split_name = auth_info.name.split(' ')
      user.first_name = split_name[0]
      user.last_name = split_name[1]
      user.image = auth_info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def admin?
    self.role == 'admin'
  end

  rails_admin do
    visible false
  end
end
