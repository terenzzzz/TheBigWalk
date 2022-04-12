# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Generate Tag
Tag.where(name:'Walker').first_or_create(name:'Walker')
if Tag.where(name:'Walker')
    puts "Created Walker Tag Successfully"
    puts "-------------------------------------"
end

Tag.where(name:'Marshal').first_or_create(name:'Marshal')
if Tag.where(name:'Marshal')
    puts "Created Marshal Tag Successfully"
    puts "-------------------------------------"
end

Tag.where(name:'Admin').first_or_create(name:'Admin')
if Tag.where(name:'Admin')
    puts "Created Admin Tag Successfully"
    puts "-------------------------------------"
end

#Account for walker
User.where(email:'test@test.com').first_or_create(name:'testWalker', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'1')
if User.where(email:'test@test.com')
    puts "Created Walker Account Successfully"
    puts "-------------------------------------"
end

#Account for Marshall
User.where(email:'testMarshall@test.com').first_or_create(name:'testMarshal', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'2')
if User.where(email:'testMarshall@test.com')
    puts "Created Marshall Account Successfully"
    puts "-------------------------------------"
end


#Account for Admin
User.where(email:'testAdmin@test.com').first_or_create(name:'testAdmin', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'3')
if User.where(email:'testAdmin@test.com.com')
    puts "Created Admin Account Successfully"
    puts "-------------------------------------"
end