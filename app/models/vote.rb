# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  voter_id     :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  validates :voter, :votable_id, :votable_type, presence: true
  validates :value, inclusion: [-1,1]

  belongs_to :voter, class_name: :User
  belongs_to :votable, polymorphic: true
end
