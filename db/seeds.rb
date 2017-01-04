# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

#create standard users
5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(6)
  )
end



#created a specific user (actually updated the first user) with my credentials so that we could easily sign in without manually creating a new user.
user = User.first
user.update_attributes!(
  name: 'Gama Aguilar',
  email: 'gama-aguilar@hotmail.com',
  password: 'helloworld'
  # role: 'admin'
)

#create premium user
premium_user = User.create!(
  name: 'Premium User',
  email: 'premium@user.test',
  password: 'helloworld',
  role: 'premium'
)

#create private wikis for premium user


#create an admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

standard = User.create!(
  name: 'Standard User',
  email: 'standard@example.org',
  password: 'helloworld',
  role: 'standard'
)

users = User.all

#Create wikis

25.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(3),
    user: users.sample
  )
end

wikis = Wiki.all


#create private wikis for admin
5.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(3),
    user: admin,
    private: true
  )
end

#create private wikis for premium
5.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(3),
    user: premium_user,
    private: true
  )
end


#
# #create a member user
# member = User.create!(
#   name: "Member User",
#   email: 'member@example.com',
#   password: 'helloworld'
# )

puts "Seed finished"
puts "#{Wiki.count} Wikis created"
# puts "#{Post.count} posts created"
# puts "#{Comment.count} comments created"
puts "#{User.count} users created"
# puts "#{Vote.count} votes created"
