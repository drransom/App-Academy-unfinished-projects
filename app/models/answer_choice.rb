# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :string           not null
#  question_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :text, :question_id, presence: true

  belongs_to(
    :question,
    class_name: 'Question',
    primary_key: :id,
    foreign_key: :question_id    
  )

end
