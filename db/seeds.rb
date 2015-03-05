# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

appacademy = User.create(user_name: 'appacademy')
hackreactor = User.create(user_name: 'hackreactor')
hackbright = User.create(user_name: 'hackbright')

poll1 = Poll.create(title: 'aa_poll', author_id: appacademy.id)
poll2 = Poll.create(title: 'hb_poll', author_id: hackbright.id)

question1 = Question.create(poll_id: poll1.id, text: 'Who is the fairest of them all?')
question2 = Question.create(poll_id: poll1.id, text: 'Can I hold it back any more')
question3 = Question.create(poll_id: poll2.id, text: 'Who am I?')

answer1 = AnswerChoice.create(question_id: question1.id, text: 'Harry Potter')
answer2 = AnswerChoice.create(question_id: question1.id, text: 'Dumbledore')
answer3 = AnswerChoice.create(question_id: question2.id, text: 'Yes!')
answer4 = AnswerChoice.create(question_id: question2.id, text: 'Absolutely not.')

answer5 = AnswerChoice.create(question_id: question3.id, text: '24601')
answer6 = AnswerChoice.create(question_id: question3.id, text: 'Jean Valjean')

Response.create!(respondent: appacademy, answer_choice: answer6)
Response.create!(respondent: hackbright, answer_choice: answer2)
Response.create!(respondent: hackreactor, answer_choice: answer1)
