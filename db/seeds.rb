require 'faker'

Category.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('categories')

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')

Event.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('events')

Attending.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('attendings')

categories = ["Tech", "Music", "Social"]
categories.each do |category|
  Category.create(
    name: category
  )
end

User.create(
  email: "luke@gmail.com",
	password: "123456",
	first_name: "Luke",
	last_name: "Leveille"
)

more_users = 20
more_events = 30

more_users.times do
  User.create(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.name.split[0],
    last_name: Faker::Name.name.split[1]
  )
end

more_events.times do |id|
  year = rand(2019..2020)
  month = rand(1..12)
  month = month < 10? "0#{month}" : month
  day = rand(1..28)
  end_day = day + rand(2)
  day = day < 10? "0#{day}" : day
  end_day = end_day < 10? "0#{end_day}" : end_day
  hour = rand(10..19)
  end_hour = hour + rand(4)
  min = ['00', '30'].sample
  user = rand(0..more_users)+1

  Event.create(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    image_link: "https://picsum.photos/id/#{rand(1..1000)}/500/300",
    category_id: rand(1..3),
    user_id: user,
    limit: rand(4..more_users),
    start: "#{year}-#{month}-#{day} #{hour}:#{min}",
    end: "#{year}-#{month}-#{end_day} #{end_hour}:#{min}",
    lat: Faker::Address.latitude,
    long: Faker::Address.longitude
  )
  Attending.create(
    user_id: user,
    event_id: id+1
  )
end



((more_users + more_events)*2).times do
  event = {}
  loop do
    event = Event.find(rand(1..more_events))
    break if event.users.length < event.limit
  end

  Attending.create(
    user_id: rand(0..more_users)+1,
    event_id: event.id
  )
end