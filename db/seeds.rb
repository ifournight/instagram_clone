# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { name: 'ifournight', email: 'ifournight@gmail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.zone.now, sign_in_count: 0 },
  { name: 'momo', email: 'momo@gmail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.zone.now, sign_in_count: 0 },
  { name: 'sweetkuma', email: 'sweetkuma@gmail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.zone.now, sign_in_count: 0 },
  { name: 'ifournighthk', email: 'ifournighthk@gmail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.zone.now, sign_in_count: 0 }
])