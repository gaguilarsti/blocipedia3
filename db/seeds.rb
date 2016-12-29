# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

#create users
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all

#Create wikis

15.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    user: users.sample 
  )
end

wikis = Wiki.all

# #Create Posts
# 50.times do
#   #Adding a ! to the method instructs it raise an error if there's the problem with the data we're seeding.
#   post = Post.create!(
#   #Initially here, we referenced a class that doesn't exist.  This is wishful coding but ok.  :)
#     user: users.sample,
#     topic: topics.sample,
#     title: RandomData.random_sentence,
#     body: RandomData.random_paragraph
#   )
#
#   post.update_attribute(:created_at, rand(10.minutes..1.year).ago)
#
#   rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
# end
#
# posts = Post.all

# #Create comments
# #using an integer on .times will make sure this thing will run x times.
# 100.times do
#   Comment.create!(
#     user: users.sample,
#     # call sample on the array returned by Post.all in order to pick a random post to associate with each comment.
#     post: posts.sample,
#     body: RandomData.random_paragraph
#   )
# end
#
#created a specific user (actually updated the first user) with my credentials so that we could easily sign in without manually creating a new user.
user = User.first
user.update_attributes!(
  name: 'Gama Aguilar',
  email: 'gama-aguilar@hotmail.com',
  password: 'helloworld'
  # role: 'admin'
)

# #create an admin user
# admin = User.create!(
#   name: 'Admin User',
#   email: 'admin@example.com',
#   password: 'helloworld',
#   role: 'admin'
# )
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
