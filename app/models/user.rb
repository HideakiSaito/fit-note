class User < ActiveRecord::Base
  attr_accessor :password , :password_confirmation

  validates :password, presence: false, on: :facebook_login
  validates :password,presence: { on: :create }, confirmation: { allow_blank: true }

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  def self.from_omniauth(auth)
    # emailの提供は必須とする
    user = User.where('email = ?', auth.info.email).first
    if user.blank?
      user = User.new
    end
    user.uid   = auth.uid
    user.name  = auth.info.name
    user.email = auth.info.email
    user.icon  = auth.info.image
    user.oauth_token      = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user
  end
  class << self
    def authenticate(email,password)
      user = find_by(email: email)
      if user && user.hashed_password.present? &&
        BCrypt::Password.new(user.hashed_password) == password
        user
      else
        nil
      end
    end
  end
end
