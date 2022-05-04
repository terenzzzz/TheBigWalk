# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Generate Tag
Tag.where(name:'Walker').first_or_create(name:'Walker')
if Tag.where(name:'Walker').first
    puts "Created Walker Tag Successfully"
    puts "-------------------------------------"
end

Tag.where(name:'Marshal').first_or_create(name:'Marshal')
if Tag.where(name:'Marshal').first
    puts "Created Marshal Tag Successfully"
    puts "-------------------------------------"
end

Tag.where(name:'Admin').first_or_create(name:'Admin')
if Tag.where(name:'Admin').first
    puts "Created Admin Tag Successfully"
    puts "-------------------------------------"
end




# #Create Event
# Event.where(name:'The Big Walk 2022').first_or_create(name:'The Big Walk 2022')
# if Event.where(email:'The Big Walk 2022')
#     puts "Created Event Successfully"
#     puts "-------------------------------------"
# end

# #Create Branding
# Branding.where(events_id:'1').first_or_create(events_id:'1')
# if Branding.where(events_id:'1')
#     puts "Created Branding Successfully"
#     puts "-------------------------------------"
# end

# #Create Route
# Route.where(name:'50km').first_or_create(name:'50km', course_length: '50', start_date: '2022-06-12', start_time: '2000-01-01 10:00:00.000000000 +0000', end_date_time: '2022-06-12 19:00:00.000000000 +0000', events_id:'1')
# if Route.where(name:'50km')
#     puts "Created Route Successfully"
#     puts "-------------------------------------"
# end

# #Create Checkpoint
# Checkpoint.where(name:'Hope Cross').first_or_create(name:'Hope Cross', os_grid: 'SK160876', events_id:'1')
# if Checkpoint.where(name:'Hope Cross')
#     puts "Created Checkpoint Successfully"
#     puts "-------------------------------------"
# end

# #Create Checkpoint 2
# Checkpoint.where(name:'Win Hill').first_or_create(name:'Win Hill', os_grid: 'SK160876', events_id:'1')
# if Checkpoint.where(name:'Win Hill')
#     puts "Created Checkpoint 2 Successfully"
#     puts "-------------------------------------"
# end

# #Create Linker
# RoutesAndCheckpointsLinker.where(distance_from_start:'10').first_or_create(distance_from_start:'10', checkpoint_description: 'Follow the summit top on and down the other side', advised_time: '10', route_id: '1', checkpoint_id: '1', position_in_route: '1')
# if RoutesAndCheckpointsLinker.where(distance_from_start:'10')
#     puts "Created Linker Successfully"
#     puts "-------------------------------------"
# end

# #Create Linker 2
# RoutesAndCheckpointsLinker.where(distance_from_start:'20').first_or_create(distance_from_start:'20', checkpoint_description: 'Follow the summit top on and down the other side', advised_time: '10', route_id: '1', checkpoint_id: '2', position_in_route: '2')
# if RoutesAndCheckpointsLinker.where(distance_from_start:'20')
#     puts "Created Linker 2 Successfully"
#     puts "-------------------------------------"
# end


# #Account for walker
# User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'1')
# if User.where(email:'walker@test.com')
#     puts "Created Walker Account Successfully"
#     puts "-------------------------------------"
# end
# Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', checkpoints_id: '1', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', opted_in_leaderboard: true)
# if Participant.where(participant_id:'1001')
#     puts "Created Walker Successfully"
#     puts "-------------------------------------"
# end
# Pickup.where(os_grid: 'SK123456').first_or_create(os_grid:'SK123456', user_id: '1', event_id: '1')
# if Pickup.where(os_grid:'SK123456')
#     puts "Created Walker pickup Successfully"
#     puts "-------------------------------------"
# end
# Call.where(user_id: '1').first_or_create(user_id: '1', event_id: '1')
# if Call.where(user_id: '1')
#     puts "Created Walker call Successfully"
#     puts "-------------------------------------"
# end

# #Account for walker 2
# User.where(email:'walker2@test.com').first_or_create(name:'walkerTest2', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'1')
# if User.where(email:'walker2@test.com')
#     puts "Created Walker Account 2 Successfully"
#     puts "-------------------------------------"
# end
# Participant.where(participant_id:'1002').first_or_create(participant_id:'1002', checkpoints_id: '2', user_id: '2', status: 'none', rank: '2', pace: 'Falling Behind!', routes_id: '1', opted_in_leaderboard: true)
# if Participant.where(participant_id:'1002')
#     puts "Created Walker 2 Successfully"
#     puts "-------------------------------------"
# end

#(1..5).each do |id|
#Event.create(name: Faker::Mountain.range)
Event.create(name:'The Big Walk 2022', made_public: true, phone_number:'00000000')
if Event.where(name:'The Big Walk 2022', made_public: true, phone_number:'00000000').first
    puts "Created Event Successfully"
    puts "-------------------------------------"
end

Branding.create(events_id: '1')
if Branding.where(events_id: '1').first
    puts "Created Branding Successfully"
    puts "-------------------------------------"
end

Route.create(name: '50km') do |route|
    route.course_length = '50'
    #route.start_date = '2022-06-12'
    #route.start_time = '2000-01-01 10:00:00.000000000 +0000'
    route.end_date_time = '2022-06-12 19:00:00.000000000 +0000' 
    route.start_time = '2000-01-01 20:40:00.000000000 +0000'
    route.start_date = '2022-05-01'
    #route.events_id = Event.where(name: 'The Big Walk 2022').first.id
    route.events_id = '1'
    if Route.where(name: '50km').first
        puts "Created Route Successfully"
        puts "-------------------------------------"
    end
end
puts "#{Route.where(name: '50km').first.id}"
start_dist = 0
end_dist = 0
(1..20).each do |check_id|
    #Checkpoint.create(name: Faker::Fantasy::Tolkien.unique.location) do |checkpoint|
    Checkpoint.create(name: Faker::Address.unique.street_name) do |checkpoint|
        checkpoint.os_grid = 'SK331896'
        checkpoint.events_id = '1'
        puts "created checkpoint #{check_id}"
    end
    puts "#{Checkpoint.where(os_grid: 'SK331896').first.id}"
    RoutesAndCheckpointsLinker.create(distance_from_start: Faker::Number.between(from: start_dist, to: end_dist)) do |linker|
        start_dist = end_dist + 1
        end_dist = end_dist + 5
        linker.checkpoint_description = Faker::Lorem.paragraph
        linker.advised_time = '20'
        linker.route_id = '1'
        linker.checkpoint_id = check_id
        linker.position_in_route = check_id
        if RoutesAndCheckpointsLinker.where(checkpoint_id: check_id, position_in_route: check_id).first
            puts "created linker #{check_id}"
            puts "-------------------------------------"
        end
    end
end

#end


# #Account for walker
User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'1')
if User.where(email:'walker@test.com')
    puts "Created Walker Account Successfully"
    puts "-------------------------------------"
end
puts "#{User.where(id: 1).first.id}"

Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', checkpoints_id: '2', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
if Participant.where(participant_id:'1001').first
    puts "Created Walker Successfully"
    puts "-------------------------------------"
end

OptedInLeaderboard.where(user_id: 1).first_or_create(opted_in: true)
if OptedInLeaderboard.where(user_id: 1, opted_in: true).first
    puts "Created OptedInLeaderboard Successfully"
    puts "-------------------------------------"
end

Pickup.where(os_grid: 'SK123456').first_or_create(os_grid:'SK123456', user_id: '1', event_id: '1')
if Pickup.where(os_grid:'SK123456',user_id: '1', event_id: '1').first
    puts "Created Walker pickup Successfully"
    puts "-------------------------------------"
end

Call.where(user_id: '1').first_or_create(user_id: '1', event_id: '1')
if Call.where(user_id: '1',event_id: '1').first
    puts "Created Walker call Successfully"
    puts "-------------------------------------"
end

#Account for Marshall
User.where(email:'marshal@test.com').first_or_create(name:'testMarshal', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'2')
if User.where(email:'marshal@test.com')
    puts "Created Marshall Account Successfully"
    puts "-------------------------------------"
end

Marshall.where(marshal_id:'2001').first_or_create(marshal_id:'2001', users_id: '2')
if Marshall.where(marshal_id:'2001',  users_id: '2').first
    puts "Created Marshall Successfully"
    puts "-------------------------------------"
end

(3..102).each do |id|
    User.create(email: Faker::Internet.unique.email) do |user|
        user.name = Faker::Fantasy::Tolkien.character
        #user.name = Faker::Name.name
        user.mobile = Faker::Number.number(digits: 11)
        user.password = "Testtest1!"
        user.password_confirmation = "Testtest1!"
        user.tag_id = 1
        if User.where(id: user.id).first
            puts "created user #{id}"
            puts "-------------------------------------"
        end
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
        if Participant.where(participant_id: walker.participant_id).first
            puts "created walker #{id}"
            puts "-------------------------------------"
        end
    end
    puts "#{Participant.all.first.id}"
    OptedInLeaderboard.create(user_id: id, opted_in: true)
end

(1..10).each do |id|
    Pickup.create(os_grid: 'SK123456') do |pickup|
        pickup.user_id = Faker::Number.unique.within(range: 2..101) 
        pickup.event_id = '1'
        if Pickup.where(id: id).first
            puts "created Pickup #{id}"
            puts "-------------------------------------"
        end
    end
    Call.create(user_id: Faker::Number.unique.within(range: 2..101)) do |call|
        call.event_id = '1'
        if Call.where(id: id).first
            puts "created call request #{id}"
            puts "-------------------------------------"
        end
    end
end

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
            
            puts "created checkpoint time #{check_num} for walker #{ids}"
        end
    end
end


(1..10).each do |id|
    User.create(email: Faker::Internet.unique.email) do |user|
        user.name = Faker::Fantasy::Tolkien.character
        #user.name = Faker::Name.name
        user.mobile = Faker::Number.number(digits: 11)
        user.password = "testtest"
        user.password_confirmation = "testtest"
        user.tag_id = 2
        puts "created user #{id + 102}"
    end
    Marshall.create(marshal_id: Faker::Number.unique.within(range: 2002..2999)) do |marshal|
        marshal.checkpoints_id = Faker::Number.unique.within(range: 2..20)
        marshal.users_id = id + 102
        puts "created marshal #{id + 1} for id #{id + 102}"
    end
end




# #Account for Marshall 2
# User.where(email:'marshal2@test.com').first_or_create(name:'testMarshal2', mobile:'0000', password:'testtest', password_confirmation:'testtest',tag_id:'2')
# if User.where(email:'marshal2@test.com')
#     puts "Created Marshall Account 2 Successfully"
#     puts "-------------------------------------"
# end
# Marshall.where(marshal_id:'2002').first_or_create(marshal_id:'2002', checkpoints_id: '2', users_id: '4')
# if Marshall.where(marshal_id:'2002')
#     puts "Created Marshall 2 Successfully"
#     puts "-------------------------------------"
# end

#Account for Admin
User.where(email:'admin@test.com').first_or_create(name:'testAdmin', mobile:'0000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'3')
if User.where(email:'admin@test.com')
    puts "Created Admin Account Successfully"
    puts "-------------------------------------"
end


puts "Seeds Finished"