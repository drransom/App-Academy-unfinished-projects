User.destroy_all
Sub.destroy_all
Post.destroy_all
SubPost.destroy_all


u1 = User.create!(user_name: 'eric', password_digest: '123456')
u2 = User.create!(user_name: 'Elliot', password_digest: '123456')

2.times do
  Sub.create!(title: Faker::App.name, moderator_id: 1)
  Sub.create!(title: Faker::App.name, moderator_id: 2)
end

3.times do
  Post.create!(title: Faker::Lorem.sentence, author_id: 1, sub_id: 1)
  Post.create!(title: Faker::Lorem.sentence, author_id: 1, sub_id: 2)
  Post.create!(title: Faker::Lorem.sentence, author_id: 2, sub_id: 1)
  Post.create!(title: Faker::Lorem.sentence, author_id: 2, sub_id: 2)
end
