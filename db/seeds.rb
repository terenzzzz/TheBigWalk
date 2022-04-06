# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Account for walker
User.where(email:'test@test.com').first_or_create(password:'testtest', password_confirmation:'testtest',tag_ids:'1')

#Account for Marshall
User.where(email:'testMarshall@test.com').first_or_create(password:'testtest', password_confirmation:'testtest',tag_ids:'2')

#Account for Admin
User.where(email:'testAdmin@test.com').first_or_create(password:'testtest', password_confirmation:'testtest',tag_ids:'3')