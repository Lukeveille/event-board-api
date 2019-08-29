FactoryGirl.define do
  factory :user do
    User.create(
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password,
      first_name: Faker::Name.name.split[0],
      last_name: Faker::Name.name.split[1]
    )
  end
end
