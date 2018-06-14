# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
Event.create(game: "Tekken 7 #{i}", name: "Tekken world tour #{i}", place: "Paris#{i}", date:"21 juin 2020", attendee: 99, style: "fighting",
   image:"https://dotesports-cdn-prod-tqgiyve.stackpathdns.com/thumbor/n55DItIePa3H_bF8We-N9S5lk9Q=/1200x0/filters:no_upscale()/https://dotesports-cdn-prod-tqgiyve.stackpathdns.com/article/a398d308-6359-4ccd-9989-3696496bb9bc.jpg"
  )
end
