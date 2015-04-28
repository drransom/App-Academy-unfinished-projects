# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  include Commentable
  validates :username, presence: true, uniqueness: true

  has_many :contacts
  has_many :contact_shares, dependent: :destroy
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

end
