# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts"---------------------------------------- Seed Started Please Wait-----------------------------------------"
#Generate Tag
Tag.where(name:'Walker').first_or_create(name:'Walker')
Tag.where(name:'Marshal').first_or_create(name:'Marshal')
Tag.where(name:'Admin').first_or_create(name:'Admin')
print'.'

#Event
Event.create(name:'The Big Walk 2022', made_public: true, phone_number:'00000000000')
print'.'

#Branding
Branding.create(events_id: '1')
print'.'

#Route
Route.create(name: '50km') do |route|
    route.course_length = '50'
    #route.start_date = '2022-06-12'
    #route.start_time = '2000-01-01 10:00:00.000000000 +0000'
    route.end_date_time = '2022-06-12 19:00:00.000000000 +0000' 
    route.start_time = '2000-01-01 20:40:00.000000000 +0000'
    route.start_date = '2022-05-01'
    #route.events_id = Event.where(name: 'The Big Walk 2022').first.id
    route.events_id = '1'
    print'.'
end
print'.'

start_dist = 0
end_dist = 0
(1..20).each do |check_id|
    #Checkpoint.create(name: Faker::Fantasy::Tolkien.unique.location) do |checkpoint|
    Checkpoint.create(name: Faker::Address.unique.street_name) do |checkpoint|
        checkpoint.os_grid = 'SK331896'
        checkpoint.events_id = '1'
        
    end

    RoutesAndCheckpointsLinker.create(distance_from_start: Faker::Number.between(from: start_dist, to: end_dist)) do |linker|
        start_dist = end_dist + 1
        end_dist = end_dist + 5
        linker.checkpoint_description = Faker::Lorem.paragraph
        linker.advised_time = '20'
        linker.route_id = '1'
        linker.checkpoint_id = check_id
        linker.position_in_route = check_id
    end
    print'.'
end
print'.'

#Account for walker
User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'1')
print'.'

Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', checkpoints_id: '2', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
print'.'

OptedInLeaderboard.where(user_id: 1).first_or_create(opted_in: true)
print'.'

#Pickup
Pickup.where(os_grid: 'SK123456').first_or_create(os_grid:'SK123456', user_id: '1', event_id: '1')
print'.'

#Call
Call.where(user_id: '1').first_or_create(user_id: '1', event_id: '1')
print'.'

#Account for Marshall
User.where(email:'marshal@test.com').first_or_create(name:'testMarshal', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'2')
Marshall.where(marshal_id:'2001').first_or_create(marshal_id:'2001', users_id: '2')
print'.'

#Multiple User For Participant
(3..102).each do |id|
    User.create(email: Faker::Internet.unique.email) do |user|
        user.name = Faker::Fantasy::Tolkien.character
        #user.name = Faker::Name.name
        user.mobile = Faker::Number.number(digits: 11)
        user.password = "Testtest1!"
        user.password_confirmation = "Testtest1!"
        user.tag_id = 1
    end
    
    Participant.create(participant_id: Faker::Number.unique.within(range: 1002..1999)) do |walker|
        walker.checkpoints_id = Faker::Number.within(range: 1..20)
        walker.user_id = id
        walker.status = 'none'
        walker.rank = id
        if (id % 9) == 0
            walker.pace = 'Falling Behind!'
        else
            walker.pace = 'On Pace.'
        end
        walker.routes_id = '1'
        walker.event_id = '1'
    end
    OptedInLeaderboard.create(user_id: id, opted_in: true)
    print'.'
end
print'.'

#Multiple Pick up and Call
(1..10).each do |id|
    Pickup.create(os_grid: 'SK123456') do |pickup|
        pickup.user_id = Faker::Number.unique.within(range: 2..101) 
        pickup.event_id = '1'

    end
    Call.create(user_id: Faker::Number.unique.within(range: 2..101)) do |call|
        call.event_id = '1'

    end
    print'.'
end
print'.'

#Multiple time for Walker
(3..101).each do |ids|
    #get walker
    walker = Participant.where(id: ids).first
    #check checkpoint pos
    linker = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first
    pos = linker.position_in_route
    #create that many checkpoint times
    start_time = DateTime.now
    end_time = DateTime.now
    (1..pos).each do |check_num|
        CheckpointTime.create(times: Faker::Time.between(from: start_time, to: end_time, format: :default)) do |time|
            start_time = end_time + 0.01
            end_time = end_time + 0.05
            time.checkpoint_id = check_num
            time.participant_id = ids

        end
    end
    print'.'
end
print'.'

#Multiple User For Marshal
(1..10).each do |id|
    User.create(email: Faker::Internet.unique.email) do |user|
        user.name = Faker::Fantasy::Tolkien.character
        #user.name = Faker::Name.name
        user.mobile = Faker::Number.number(digits: 11)
        user.password = "testtest"
        user.password_confirmation = "testtest"
        user.tag_id = 2
    end
    Marshall.create(marshal_id: Faker::Number.unique.within(range: 2002..2999)) do |marshal|
        marshal.checkpoints_id = Faker::Number.unique.within(range: 2..20)
        marshal.users_id = id + 102
    end
    print'.'
end
print'.'

#Account for Admin
User.where(email:'admin@test.com').first_or_create(name:'testAdmin', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'3')
print'.'

#Print statment
puts ""
puts "----------------------------------------Seeds Finished----------------------------------------"
#Tag 
if Tag.where(name:'Walker').first
    puts "Created Walker Tag Successfully"
    puts "-------------------------------------"
else
    puts "Created Walker Tag Fail"
    puts "-------------------------------------"
end

if Tag.where(name:'Marshal').first
    puts "Created Marshal Tag Successfully"
    puts "-------------------------------------"
else
    puts "Created Marshal Tag Fail"
    puts "-------------------------------------"
end

if Tag.where(name:'Admin').first
    puts "Created Admin Tag Successfully"
    puts "-------------------------------------"
else
    puts "Created Admin Tag Fail"
    puts "-------------------------------------"
end

#Event
if Event.where(name:'The Big Walk 2022', made_public: true, phone_number:'00000000000').first
    puts "Created Event Successfully"
    puts "-------------------------------------"
else
    puts "Created Event Fail"
    puts "-------------------------------------"
end

#Branding
if Branding.where(events_id: '1').first
    puts "Created Branding Successfully"
    puts "-------------------------------------"
else
    puts "Created Branding Fail"
    puts "-------------------------------------"
end

#Route
if Route.where(name: '50km', events_id:'1').first
    puts "Created Route Successfully"
    puts "-------------------------------------"
else
    puts "Created Route Fail"
    puts "-------------------------------------"
end

#Checkpoint
if Checkpoint.where(id: 19).first
    puts "Created 20 Checkpoints Successfully"
    puts "-------------------------------------"
else
    puts "Created 20 Checkpoints Fail"
    puts "-------------------------------------"
end

#RoutesAndCheckpointsLinker
if RoutesAndCheckpointsLinker.where(id: 19).first
    puts "Created 20 Linkers Successfully"
    puts "-------------------------------------"
else
    puts "Created 20 Linkers Fail"
    puts "-------------------------------------"
end

#Walker
if  User.where(email:'walker@test.com',name:'testWalker', mobile:'00000000000',tag_id:'1')
    puts "Created Walker User Successfully"
    puts "-------------------------------------"
else
    puts "Created Walker User Fail"
    puts "-------------------------------------"
end

#Participnt
if  Participant.where(participant_id:'1001',checkpoints_id: '2', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
    puts "Created Participant Successfully"
    puts "-------------------------------------"
else
    puts "Created Participant Fail"
    puts "-------------------------------------"
end

#OptedInLeaderboard
if OptedInLeaderboard.where(user_id: 1, opted_in: true).first
    puts "Created OptedInLeaderboard For user 1 Successfully"
    puts "-------------------------------------"
else
    puts "Created OptedInLeaderboard For user 1 Fail"
    puts "-------------------------------------"
end

#Pickup
if Pickup.where(os_grid:'SK123456',user_id: '1', event_id: '1').first
    puts "Created Walker pickup Successfully"
    puts "-------------------------------------"
else
    puts "Created Walker pickup Fail"
    puts "-------------------------------------"
end

if Pickup.where(id: 9).first
    puts "created 10 Pickups Successfully"
    puts "-------------------------------------"
else
    puts "Created 10 Pickups Fail"
    puts "-------------------------------------"
end

#Call
if Call.where(user_id: '1',event_id: '1').first
    puts "Created Walker call Successfully"
    puts "-------------------------------------"
else
    puts "Created Walker call Fail"
    puts "-------------------------------------"
end

if Call.where(id: 9).first
    puts "created 10 call requests Successfully"
    puts "-------------------------------------"
else
    puts "created 10 call requests Fail"
    puts "-------------------------------------"
end

#Marshal
if  User.where(name:'testMarshal', mobile:'00000000000',tag_id:'2')
    puts "Created Marshal User Successfully"
    puts "-------------------------------------"
else
    puts "Created Marshal User Fail"
    puts "-------------------------------------"
end

if Marshall.where(marshal_id:'2001',  users_id: '2').first
    puts "Created Marshall Successfully"
    puts "-------------------------------------"
else
    puts "Created Marshall Fail"
    puts "-------------------------------------"
end

#Multiple Marshals
if User.where(tag_id: '2',  id: '111').first
    puts "Created Multiple Marshall User Successfully"
    puts "-------------------------------------"
else
    puts "Created Multiple Marshall User Fail"
    puts "-------------------------------------"
end

if Marshall.where(users_id: '111').first
    puts "Created Multiple Marshalls Successfully"
    puts "-------------------------------------"
else
    puts "Created Multiple Marshalls Fail"
    puts "-------------------------------------"
end

#Multiple User For Participant
if User.where(id: 101).first
    puts "created Multiple User For Participant Successfully"
    puts "-------------------------------------"
else
    puts "created Multiple User For Participant Fail"
    puts "-------------------------------------"
end

if Participant.where(user_id: 101).first
    puts "created Multiple Participant Successfully"
    puts "-------------------------------------"
else
    puts "created Multiple User Fail"
    puts "-------------------------------------"
end

#CheckpointTime
if CheckpointTime.where(checkpoint_id: 5).first
    puts "created Multiple CheckpointTime Successfully"
    puts "-------------------------------------"
else
    puts "created Multiple CheckpointTime Fail"
    puts "-------------------------------------"
end

#Admin
if User.where(email:'admin@test.com',name:'testAdmin', mobile:'00000000000',tag_id:'3')
    puts "Created Admin Account Successfully"
    puts "-------------------------------------"
else
    puts "Created Admin Account Fail"
    puts "-------------------------------------"
end

puts "----------------------------------------Seeds Finished----------------------------------------"