# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "tyler", email: "tyler@email.com", password: "password")
User.create(name: "test", email: "test@email.com", password: "password")

Team.create(name: "Chicago Cubs")
Team.create(name: "Chicago Bulls")
Team.create(name: "Aston Villa")
Team.create(name: "New York Yankees")
