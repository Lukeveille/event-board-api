Category.destroy_all

categories = ["Tech", "Music", "Social"]

categories.each do |category|
  Category.create(
    name: category
  )
end