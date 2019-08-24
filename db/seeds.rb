Category.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('categories')

categories = ["Tech", "Music", "Social"]

categories.each do |category|
  Category.create(
    name: category
  )
end