require 'bcrypt'

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true

  after_initialize :ensure_session_token

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  def self.generate_session_token
    SecureRandom::base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.where(email: email).take
    (user && user.is_password?(password)) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token || reset_session_token!
  end
end
