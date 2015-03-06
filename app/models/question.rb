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
  validates :poll_id, :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :poll_id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id
  )

  has_many(:responses, through: :answer_choices, source: :responses)

  def results_n_plus_one_query
    results = {}
    answer_choices.each do |choice|
      results[choice.text] = choice.responses.count
    end
    results
  end

  def results_inefficient_includes
    results = {}
    answer_choices.includes(:responses).each do |choice|
      results[choice.text] = choice.responses.length
    end
    results
  end

  def results
    result = answer_choices
      .select("answer_choices.text, COUNT(responses.*) AS count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")

      result.map { |i| [i.text, i.count] }.to_h
  end
end
