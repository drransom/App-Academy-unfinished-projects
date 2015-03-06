# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :user_has_not_already_answered_question, :user_is_not_poll_creator

  belongs_to(
    :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_choice_id
  )

  has_one(:question, through: :answer_choice, source: :question)

  def sibling_responses
    # debugger
    question.responses.where(":id IS NULL OR responses.id != :id", id: id)
  end

  def user_has_not_already_answered_question
    if sibling_responses.where("responses.user_id = ?", user_id).count > 0
      errors[:user] << "has already answered this question."
    end
  end

  def user_is_not_poll_creator
    if answer_choice.question.poll.author_id == user_id
      errors[:user] << "is the creator of this poll"
    end
  end
end
