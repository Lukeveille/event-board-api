FactoryGirl.define do
  factory :event do
    year = rand(2019..2020)
    month = rand(1..12)
    month = double_zero(month)
    day = rand(1..28)
    end_day = day + rand(2)
    day = double_zero(day)
    end_day = double_zero(end_day)
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
end
