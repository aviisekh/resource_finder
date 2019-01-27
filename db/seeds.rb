# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Person.create!(name: 'Ram', start_time: Time.utc(2019, 1, 1, 5, 00), end_time: Time.utc(2019, 1, 1, 7, 00))
Person.create!(name: 'Ram', start_time: Time.utc(2019, 1, 1, 15, 00), end_time: Time.utc(2019, 1, 1, 20, 45))
Person.create!(name: 'Shyam', start_time: Time.utc(2019, 1, 1, 12, 00), end_time: Time.utc(2019, 1, 1, 18, 30))
Person.create!(name: 'Hari', start_time: Time.utc(2019, 1, 1, 8, 00), end_time: Time.utc(2019, 1, 1, 23, 59))
