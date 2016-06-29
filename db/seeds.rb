require 'random_data'

3.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: "rappecep"
  )
end

users = User.all

10.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    private: false,
    user: users.sample
  )
end

puts "Seeding finished"
puts "#{User.count} users create"
puts "#{Wiki.count} wikis created"
