# == Schema Information
#
# Table name: logins
#
#  id            :integer          not null, primary key
#  session_token :string           not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Login < ActiveRecord::Base
  validates :user_id, presence: true
  validates :session_token, presence: true, uniqueness: true

  belongs_to :user

  after_initialize do
    reset_session_token! unless session_token
  end

  def reset_session_token!
    self.update(session_token: SecureRandom::base64)
  end
end
