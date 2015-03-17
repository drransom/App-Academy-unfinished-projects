# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  user_id    :integer          not null
#  private    :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :user, :content, presence: true
  validates :private, inclusion: [true, false]

  belongs_to :user
end
