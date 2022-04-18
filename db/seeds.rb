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

#Create Event
Event.where(name:'The Big Walk 2022').first_or_create(name:'The Big Walk 2022')
if Event.where(email:'The Big Walk 2022')
    puts "Created Event Successfully"
    puts "-------------------------------------"
end

#Create Branding
Branding.where(events_id:'1').first_or_create(events_id:'1')
if Branding.where(events_id:'1')
    puts "Created Branding Successfully"
    puts "-------------------------------------"
end

#Create Route
Route.where(name:'50km').first_or_create(name:'50km', course_length: '50', start_date: '2022-04-12', start_time: '2000-01-01 19:06:00.000000000 +0000', events_id:'1')
if Route.where(name:'50km')
    puts "Created Route Successfully"
    puts "-------------------------------------"
end

#Create Checkpoint
Checkpoint.where(name:'Hope Cross').first_or_create(name:'Hope Cross', os_grid: 'SK160876', events_id:'1')
if Checkpoint.where(name:'Hope Cross')
    puts "Created Checkpoint Successfully"
    puts "-------------------------------------"
end

#Create Linker
RoutesAndCheckpointsLinker.where(distance_from_start:'24.9').first_or_create(distance_from_start:'24.9', checkpoint_description: 'Follow the summit top on and down the other side', advised_time: '10', route_id: '1', checkpoint_id: '1')
if RoutesAndCheckpointsLinker.where(distance_from_start:'24.9')
    puts "Created Linker Successfully"
    puts "-------------------------------------"
end

#Account for walker
User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'1')
if User.where(email:'walker@test.com')
    puts "Created Walker Account Successfully"
    puts "-------------------------------------"
end
Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', check_point_id: '1', user_id: '2', checkpoints_id: '1', users_id: '1', route_id: '1', status: 'none', rank: '1', pace: 'on pace', routes_id: '1')
if Participant.where(participant_id:'1001')
    puts "Created Walker Successfully"
    puts "-------------------------------------"
end

#Account for Marshall
User.where(email:'marshal@test.com').first_or_create(name:'testMarshal', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'2')
if User.where(email:'marshal@test.com')
    puts "Created Marshall Account Successfully"
    puts "-------------------------------------"
end
Marshall.where(marshal_id:'2001').first_or_create(marshal_id:'2001', checkPoint_id: '1', user_id: '2', checkpoints_id: '1', users_id: '2')
if Marshall.where(marshal_id:'2001')
    puts "Created Marshall Successfully"
    puts "-------------------------------------"
end

User.where(email:'marshal2@test.com').first_or_create(name:'testMarshal2', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'2')
if User.where(email:'marshal2@test.com')
    puts "Created Marshall Account Successfully"
    puts "-------------------------------------"
end
Marshall.where(marshal_id:'2002').first_or_create(marshal_id:'2002', checkPoint_id: '1', user_id: '3', checkpoints_id: '1', users_id: '3')
if Marshall.where(marshal_id:'2002')
    puts "Created Marshall Successfully"
    puts "-------------------------------------"
end

#Account for Admin
User.where(email:'admin@test.com').first_or_create(name:'testAdmin', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'3')
if User.where(email:'admin@test.com')
    puts "Created Admin Account Successfully"
    puts "-------------------------------------"
end