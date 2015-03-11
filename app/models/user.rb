# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  validates :password_digest, presence: true
  validates :username, :session_token, presence: true, uniqueness: true
  has_many :cats
  has_many(
    :requested_rentals,
    class_name: 'CatRentalRequest',
    primary_key: :id,
    foreign_key: :requestor_id
  )
  has_many(
    :requests_on_owned_cat,
    through: :cats,
    source: :cat_rental_requests
  )

  after_initialize do
    reset_session_token! unless session_token
  end

  def reset_session_token!
    self.update(session_token: SecureRandom::base64)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.where(username: username).take
    (user && user.is_password?(password)) ? user : nil
  end
end
