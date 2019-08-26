Category.destroy_all
User.destroy_all
Event.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('events')

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

Event.create(
  name: "A time and a place",
  description: "Things happen and it's gonna be awesome",
  image_link: "d2b7dtg3ypekdu.cloudfront.net/1/c0c3c43f-The+Sun.jpg",
  category_id: 1,
  user_id: 1,
  limit: 10,
  start: "2019-08-21 00:00:00",
  end: "2019-08-29 15:30:00",
  lat: 43.6383698,
  long: -79.43533409999999
)