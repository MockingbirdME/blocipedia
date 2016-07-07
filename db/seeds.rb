require 'random_data'

  3.times do
    User.create!(
      name: Faker::StarWars.character,
      email: Faker::Internet.free_email,
      password: "rappecep",
      role: 0
    )
  end
  User.create!(name: 'devon', email: 'devon.henegar@gmail.com', password: 'rappecep', role: 1)
  users = User.all

  5.times do
    Wiki.create!(
      title: Faker::StarWars.droid,
      body: Faker::Hipster.paragraph,
      private: false,
      user: users.sample
    )
  end

    5.times do
      Wiki.create!(
        title: Faker::StarWars.planet,
        body: Faker::StarWars.quote,
        private: false,
        user: users.sample
      )
  end

puts "Seeding finished"
puts "#{User.count} users create"
puts "#{Wiki.count} wikis created"
