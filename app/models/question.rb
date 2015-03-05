# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validate :poll_id, :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll'
    primary_key: :id
    foreign_key: :poll_id
  )
end
