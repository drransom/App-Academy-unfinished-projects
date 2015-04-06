u1 = User.create(email: 'ripe@gmail.com', password: 'password')
u2 = User.create(email: 'thejamaicandave@gmail.com', password: 'password')
u3 = User.create(email: 'shulk@bionis.com', password: 'password')

b1 = u1.boards.create(title: 'Workout')
b2 = u1.boards.create(title: 'Jamaica')
b3 = u2.boards.create(title: 'Bouncy')
b4 = u3.boards.create(title: 'Bionis')
b5 = u3.boards.create(title: 'Mechonis')

l1 = b1.lists.create(title: 'todo')
l2 = b1.lists.create(title: 'doing')
l3 = b1.lists.create(title: 'done')
l4 = b4.lists.create(title: 'todo')
l5 = b4.lists.create(title: 'doing')
l6 = b4.lists.create(title: 'done')

c1 = l3.cards.create(title: 'squats', description: 'feel the burn')
c2 = l3.cards.create(title: 'pushups', description: 'ooh ouch')
c3 = l3.cards.create(title: 'situps', description: 'ouchy')

c4 = l1.cards.create(title: 'squats', description: 'feel the burn')
c5 = l1.cards.create(title: 'pushups', description: 'ooh ouch')
c6 = l1.cards.create(title: 'situps', description: 'ouchy')

c7 = l2.cards.create(title: 'squats', description: 'feel the burn')
c8 = l2.cards.create(title: 'pushups', description: 'ooh ouch')
c9 = l2.cards.create(title: 'situps', description: 'ouchy')

c10 = l4.cards.create(title: 'monado', description: 'power of the monado')
c11 = l4.cards.create(title: 'greatness', description: 'reallyfeelingit')
c12 = l4.cards.create(title: 'situps', description: 'ouchy')

c13 = l5.cards.create(title: 'monado', description: 'power of the monado')
c14 = l5.cards.create(title: 'greatness', description: 'reallyfeelingit')
c15 = l5.cards.create(title: 'situps', description: 'ouchy')

i1 = c1.items.create(done: false, title: 'mocha')
i2 = c1.items.create(done: true, title: 'mocha')
i3 = c1.items.create(done: true, title: 'cookie')


i4 = c10.items.create(done: false, title: 'mocha')
i5 = c10.items.create(done: true, title: 'mocha')
i6 = c10.items.create(done: true, title: 'cookie')

b1.members = [u2]
b1.save

b4.members = [u1, u2]
b4.save
