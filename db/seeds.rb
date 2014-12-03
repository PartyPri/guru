require 'faker'
 
10.times do
   User.create!(
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name, 
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(10),
      description: Faker::Lorem.sentence
   )
 end

 users = User.all

 5.times do 
  Interest.create!(
    name: Faker::Lorem.word,
    description: Faker::Lorem.sentence
    )
end

interests = Interest.all

5.times do 
  UserInterest.create(user_id: User.first.id, interest_id: interests.sample.id)
end

user_interests = UserInterest.all


interests = Interest.all

 puts "Created #{users.count} Users"
 puts "Created #{interests.count} Interests"
 puts "Created #{user_interests.count} UserInterests"