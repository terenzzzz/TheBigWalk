# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# puts"---------------------------------------- Seed Started Please Wait-----------------------------------------"
# #Generate Tag
# Tag.where(name:'Walker').first_or_create(name:'Walker')
# Tag.where(name:'Marshal').first_or_create(name:'Marshal')
# Tag.where(name:'Admin').first_or_create(name:'Admin')
# print'.'

# #Event
# Event.create(name:'The Big Walk 2022', made_public: true, phone_number:'00000000000')
# print'.'

# #Branding
# Branding.create(events_id: '1')
# print'.'

# #Route
# Route.create(name: '50km') do |route|
#     route.course_length = '50'
#     #route.start_date = '2022-06-12'
#     #route.start_time = '2000-01-01 10:00:00.000000000 +0000'
#     route.end_date_time = '2022-06-12 19:00:00.000000000 +0000' 
#     route.start_time = '2000-01-01 20:40:00.000000000 +0000'
#     route.start_date = '2022-05-01'
#     #route.events_id = Event.where(name: 'The Big Walk 2022').first.id
#     route.events_id = '1'
#     print'.'
# end
# print'.'

# start_dist = 0
# end_dist = 0
# (1..20).each do |check_id|
#     #Checkpoint.create(name: Faker::Fantasy::Tolkien.unique.location) do |checkpoint|
#     Checkpoint.create(name: Faker::Address.unique.street_name) do |checkpoint|
#         checkpoint.os_grid = 'SK331896'
#         checkpoint.events_id = '1'
        
#     end

#     RoutesAndCheckpointsLinker.create(distance_from_start: Faker::Number.between(from: start_dist, to: end_dist)) do |linker|
#         start_dist = end_dist + 1
#         end_dist = end_dist + 5
#         linker.checkpoint_description = Faker::Lorem.paragraph
#         linker.advised_time = 20
#         linker.route_id = '1'
#         linker.checkpoint_id = check_id
#         linker.position_in_route = check_id
#     end
#     print'.'
# end
# print'.'

# #Account for walker
# User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'1')
# print'.'

# Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', checkpoints_id: '2', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
# print'.'

# OptedInLeaderboard.where(user_id: 1).first_or_create(opted_in: true)
# print'.'

# #Pickup
# Pickup.where(os_grid: 'SK123456').first_or_create(os_grid:'SK123456', user_id: '1', event_id: '1')
# print'.'

# #Call
# Call.where(user_id: '1').first_or_create(user_id: '1', event_id: '1')
# print'.'

# #Account for Marshall
# User.where(email:'marshal@test.com').first_or_create(name:'testMarshal', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'2')
# Marshall.where(marshal_id:'2001').first_or_create(marshal_id:'2001', user_id: '2',checkpoints_id:1)
# # Marshall.where(marshal_id:'2001').update(checkpoints_id: nil)
# print'.'

# #Multiple User For Participant
# (3..102).each do |id|
#     User.create(email: Faker::Internet.unique.email) do |user|
#         user.name = Faker::Fantasy::Tolkien.character
#         #user.name = Faker::Name.name
#         user.mobile = Faker::Number.number(digits: 11)
#         user.password = "Testtest1!"
#         user.password_confirmation = "Testtest1!"
#         user.tag_id = 1
#     end
    
#     Participant.create(participant_id: Faker::Number.unique.within(range: 1002..1999)) do |walker|
#         walker.checkpoints_id = Faker::Number.within(range: 1..20)
#         walker.user_id = id
#         walker.status = 'none'
#         walker.rank = id
#         if (id % 9) == 0
#             walker.pace = 'Falling Behind!'
#         else
#             walker.pace = 'On Pace.'
#         end
#         walker.routes_id = '1'
#         walker.event_id = '1'
#     end
    
#     OptedInLeaderboard.create(user_id: id, opted_in: true)
#     print'.'
# end
# print'.'

# #Multiple Pick up and Call
# (1..10).each do |id|
#     Pickup.create(os_grid: 'SK123456') do |pickup|
#         pickup.user_id = Faker::Number.unique.within(range: 2..101) 
#         pickup.event_id = '1'

#     end
#     Call.create(user_id: Faker::Number.unique.within(range: 2..101)) do |call|
#         call.event_id = '1'

#     end
#     print'.'
# end
# print'.'

# #Multiple time for Walker
# (3..101).each do |ids|
#     #get walker
#     walker = Participant.where(id: ids).first
#     #check checkpoint pos
#     linker = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first
#     pos = linker.position_in_route
#     #create that many checkpoint times
#     start_time = DateTime.now
#     end_time = DateTime.now
#     (1..pos).each do |check_num|
#         CheckpointTime.create(times: Faker::Time.between(from: start_time, to: end_time, format: :default)) do |time|
#             start_time = end_time + 0.01
#             end_time = end_time + 0.05
#             time.checkpoint_id = check_num
#             time.participant_id = ids

#         end
#     end
#     print'.'
# end
# print'.'

# #Multiple User For Marshal
# (1..10).each do |id|
#     User.create(email: Faker::Internet.unique.email) do |user|
#         user.name = Faker::Fantasy::Tolkien.character
#         #user.name = Faker::Name.name
#         user.mobile = Faker::Number.number(digits: 11)
#         user.password = "Testtest1!"
#         user.password_confirmation = "Testtest1!"
#         user.tag_id = 2
#     end
#     Marshall.create(marshal_id: Faker::Number.unique.within(range: 2002..2999)) do |marshal|
#         marshal.checkpoints_id = Faker::Number.unique.within(range: 2..20)
#         marshal.user_id = id + 102
#     end
#     print'.'
# end
# print'.'

# #Account for Admin
# User.where(email:'admin@test.com').first_or_create(name:'testAdmin', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'3')
# print'.'

# #Print statment
# puts ""
# puts "----------------------------------------Seeds Finished----------------------------------------"
# #Tag 
# if Tag.where(name:'Walker').first
#     puts "Created Walker Tag Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Walker Tag Fail"
#     puts "-------------------------------------"
# end

# if Tag.where(name:'Marshal').first
#     puts "Created Marshal Tag Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Marshal Tag Fail"
#     puts "-------------------------------------"
# end

# if Tag.where(name:'Admin').first
#     puts "Created Admin Tag Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Admin Tag Fail"
#     puts "-------------------------------------"
# end

# #Event
# if Event.where(name:'The Big Walk 2022', made_public: true, phone_number:'00000000000').first
#     puts "Created Event Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Event Fail"
#     puts "-------------------------------------"
# end

# #Branding
# if Branding.where(events_id: '1').first
#     puts "Created Branding Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Branding Fail"
#     puts "-------------------------------------"
# end

# #Route
# if Route.where(name: '50km', events_id:'1').first
#     puts "Created Route Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Route Fail"
#     puts "-------------------------------------"
# end

# #Checkpoint
# if Checkpoint.where(id: 19).first
#     puts "Created 20 Checkpoints Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created 20 Checkpoints Fail"
#     puts "-------------------------------------"
# end

# #RoutesAndCheckpointsLinker
# if RoutesAndCheckpointsLinker.where(id: 19).first
#     puts "Created 20 Linkers Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created 20 Linkers Fail"
#     puts "-------------------------------------"
# end

# #Walker
# if  User.where(email:'walker@test.com',name:'testWalker', mobile:'00000000000',tag_id:'1')
#     puts "Created Walker User Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Walker User Fail"
#     puts "-------------------------------------"
# end

# #Participnt
# if  Participant.where(participant_id:'1001',checkpoints_id: '2', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
#     puts "Created Participant Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Participant Fail"
#     puts "-------------------------------------"
# end

# #OptedInLeaderboard
# if OptedInLeaderboard.where(user_id: 1, opted_in: true).first
#     puts "Created OptedInLeaderboard For user 1 Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created OptedInLeaderboard For user 1 Fail"
#     puts "-------------------------------------"
# end

# #Pickup
# if Pickup.where(os_grid:'SK123456',user_id: '1', event_id: '1').first
#     puts "Created Walker pickup Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Walker pickup Fail"
#     puts "-------------------------------------"
# end

# if Pickup.where(id: 9).first
#     puts "created 10 Pickups Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created 10 Pickups Fail"
#     puts "-------------------------------------"
# end

# #Call
# if Call.where(user_id: '1',event_id: '1').first
#     puts "Created Walker call Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Walker call Fail"
#     puts "-------------------------------------"
# end

# if Call.where(id: 9).first
#     puts "created 10 call requests Successfully"
#     puts "-------------------------------------"
# else
#     puts "created 10 call requests Fail"
#     puts "-------------------------------------"
# end

# #Marshal
# if  User.where(name:'testMarshal', mobile:'00000000000',tag_id:'2')
#     puts "Created Marshal User Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Marshal User Fail"
#     puts "-------------------------------------"
# end

# if Marshall.where(marshal_id:'2001',  user_id: '2').first
#     puts "Created Marshall Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Marshall Fail"
#     puts "-------------------------------------"
# end

# #Multiple Marshals
# if User.where(tag_id: '2').count > 10
#     puts "Created Multiple Marshall User Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Multiple Marshall User Fail"
#     puts "-------------------------------------"
# end

# if Marshall.where(user_id: '111').first
#     puts "Created Multiple Marshalls Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Multiple Marshalls Fail"
#     puts "-------------------------------------"
# end

# #Multiple User For Participant
# if User.where(id: 101).first
#     puts "created Multiple User For Participant Successfully"
#     puts "-------------------------------------"
# else
#     puts "created Multiple User For Participant Fail"
#     puts "-------------------------------------"
# end

# if Participant.where(user_id: 101).first
#     puts "created Multiple Participant Successfully"
#     puts "-------------------------------------"
# else
#     puts "created Multiple User Fail"
#     puts "-------------------------------------"
# end

# #CheckpointTime
# if CheckpointTime.where(checkpoint_id: 5).first
#     puts "created Multiple CheckpointTime Successfully"
#     puts "-------------------------------------"
# else
#     puts "created Multiple CheckpointTime Fail"
#     puts "-------------------------------------"
# end

# #Admin
# if User.where(email:'admin@test.com',name:'testAdmin', mobile:'00000000000',tag_id:'3')
#     puts "Created Admin Account Successfully"
#     puts "-------------------------------------"
# else
#     puts "Created Admin Account Fail"
#     puts "-------------------------------------"
# end

# puts "----------------------------------------Seeds Finished----------------------------------------"

################################################## seeds for presentation ##################################################

puts"---------------------------------------- Seed Started Please Wait-----------------------------------------"
#Generate Tag
Tag.where(name:'Walker').first_or_create(name:'Walker')
Tag.where(name:'Marshal').first_or_create(name:'Marshal')
Tag.where(name:'Admin').first_or_create(name:'Admin')
print'.'

#Event
Event.create(name:'The Big Walk 2022', made_public: true, phone_number:'07757291463')
print'.'

#Branding
Branding.create(events_id: '1')
print'.'

#Route
Route.create(name: '50km') do |route|
    route.course_length = '51.6'
    #route.start_date = '2022-06-12'
    #route.start_time = '2000-01-01 10:00:00.000000000 +0000'
    route.end_date_time = '2022-06-12 19:00:00.000000000 +0000' 
    route.start_time = '2000-01-01 14:05:00.000000000 +0000'
    route.start_date = '2022-05-06'
    #route.events_id = Event.where(name: 'The Big Walk 2022').first.id
    route.events_id = '1'
    print'.'
end

Route.create(name: '30km') do |route|
    route.course_length = '32.5'
    #route.start_date = '2022-06-12'
    #route.start_time = '2000-01-01 10:00:00.000000000 +0000'
    route.end_date_time = '2022-06-12 19:00:00.000000000 +0000' 
    route.start_time = '2000-01-01 14:05:00.000000000 +0000'
    route.start_date = '2022-05-06'
    #route.events_id = Event.where(name: 'The Big Walk 2022').first.id
    route.events_id = '1'
    print'.'
end
print'.'


Checkpoint.create(name: "Hope Station", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Footpath from Edale Road", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Losehill Summit", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Mam Tor summit", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Path junction / signpost", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Brown Knoll summit", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Pym Chair", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Crowden Brook", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Top of Golden Clough", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Top of Jagger's Clough", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Gate in Wall", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Hope Cross", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Win Hill summit", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Ladybower Reservoir/A6013 main road", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Bamford Edge", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "East end of Bamford Edge", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Crow Chin, Stanage Edge", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Small reservoir at the head of Rivelin Brook", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Road/path/ foot path leading through the plantation", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "Crimicar Lane, S10 4EL", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "The University Arms", os_grid: 'SK331896', events_id: '1')#21
print'.'
Checkpoint.create(name: "Edale Railway Station", os_grid: 'SK331896', events_id: '1')
print'.'
Checkpoint.create(name: "YHA Edale Activity Centre", os_grid: 'SK331896', events_id: '1')
print'.'


RoutesAndCheckpointsLinker.create(distance_from_start: '0') do |linker|
    linker.checkpoint_description = "Head to the main road (A6187) and turn right heading for Hope village. After you pass Aston Lane on
    your right take the footpath right, just before the bridge over the River Noe. At the old mill (now a
    house) it becomes a track. Follow the track until a T-junction where it meets a road and turn left over
    the bridge. When the road meets another road turn right and follow Edale Road past a pub (The
    Cheshire Cheese), under a railway bridge and shortly after look for the footpath on the left just after
    Bleak House."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '1'
    linker.position_in_route = '1'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '1.9') do |linker|
    linker.checkpoint_description = "Follow the footpath for approx. 200m. At the junction where it meets some wooden stables, take the
    footpath to the right, heading along the field boundary between a wire fence and a hedge. The path
    broadens, and shortly after a metal gate with a rock hanging from it the track opens out. Follow the
    path bearing right, beginning to head uphill through numerous fields. Pass a footpath sign for Mam
    Tor via Losehill Farm. Head for a stone barn in the field and pass this heading to Losehill Farm. At
    Losehill Farm turn left between conifers and follow the path uphill, following a signpost for Losehill.
    Follow this path until it begins to level out. Cross a stile on the right by a huge cairn (pile of rocks) and
    follow the steps up to Losehill summit for excellent views of the Edale and Hope Valleys."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '2'
    linker.position_in_route = '2'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '4.3') do |linker|
    linker.checkpoint_description = "From Losehill summit, follow the ridge towards Back Tor and then down the rough and broad track. At
    the bottom, pass through a wooden gate (on your left) and continue along the ridge with the fence /
    wall on your right. Follow the ridge past Hollins Cross to the summit of Mam Tor."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '3'
    linker.position_in_route = '3'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '7.7') do |linker|
    linker.checkpoint_description = "From Mam Tor summit, follow the path and steps down to the road. Turn left onto the road and in
    approx. 50m look for the gate and bridleway on your right. Pass through the gate and follow the path,
    which rises up to the crest of Rushup Edge. Bear right at the sign where the bridlepath and the
    footpath fork. Follow the crest of Rushup Edge with spectacular airy views, keeping the wall on your
    left. The path rises to Lord's Seat, (fenced-off burial mound) then levels off before beginning to
    descend towards the far end of Rushup Edge. As it descends the path gradually broadens and
    becomes a sunken rocky track and reaches a junction with a prominent signpost."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '4'
    linker.position_in_route = '4'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '9') do |linker|
    linker.checkpoint_description = "At the junction turn right, signposted for Edale. The track is now broad, level and sandy. Follow this
    track for approx. 300m. Where the track makes a distinct sharp turn to the right, look for the
    prominent wooden pole and paved path on your left. Follow this paved path over the open moorland
    to the brilliant white trig point at the summit of Brown Knoll."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '5'
    linker.position_in_route = '5'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '11.7') do |linker|
    linker.checkpoint_description = "From the summit, continue to follow the paved path as it descends to meet a fence. Cross the stile
    and after a few yards take the paved path leading right. The path leads gradually downhill until it
    meets a broad stony track at a large wooden gate. Go through the gate and take the path to the left
    signposted in yellow “Pennine Way” (If you follow the blue sign downhill you're going wrong!) heading
    uphill towards Swine's Back. This becomes stepped as it steepens, then it bears right following a
    broken stone wall. At the large cairn in a dip, ignore the path to the left and continue heading straight
    on, following the broken wall and drifting round to the right towards the huge stone anvil of Noe Stool."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '6'
    linker.position_in_route = '6'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '12.5') do |linker|
    linker.checkpoint_description = "The path passes to the right of Pym Chair and becomes many separate paths. They all head in the
    same direction but the paths to the right seem to be the least muddy. Head for the maze of
    Woolpacks. The path through Woolpacks can be a muddy nightmare (or a bogtrotter's delight!) Lost
    boots and shoes are quite common here so make sure your laces are tight before entering the maze!
    Woolpacks is a natural sculpture park, with amazing gritstone formations that have been sculpted by
    the wind. Look out for rocks that look like a sea lion, Homer Simpson and Snoopy! The main path is a
    peaty muddy highway that spreads out as it progresses. The best approach is to follow the general
    direction but to pick your way according to the conditions! All the different paths eventually come
    together on the other side, and there are generally hundreds of footprints to follow! From Woolpacks
    the path continues along the edge past Crowden Tower to Crowden Brook. Here the path descends
    quite steeply with steep and dramatic views on your right."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '7'
    linker.position_in_route = '7'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '17.8') do |linker|
    linker.checkpoint_description = "Cross Crowden Brook and bear right (don't follow any of the paths off left as you'll get lost in the
    interior!) After approx.1km you pass a rocky outcrop on your right resembling a pig with an open
    mouth. Someone has scratched a spiral design onto it too! Just past here the path splits and
    becomes paved. Ignore the right fork and keep left heading for the top of Grindsbrook. Keep left at
    the minor fork just before Grindsbrook. Cross the brook at a huge cairn and follow the path around
    the edge. The path swings left and follows the rim of a dramatic ravine. Follow the path until you can
    cross the stream at an open area of huge flat slabs of rock. Bear right back along the rim of the
    ravine until the path swings left and continues along the main edge. Follow the path over Upper Tor
    and Nether Tor until you reach the top of Golden Clough."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '8'
    linker.position_in_route = '8'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '20.2') do |linker|
    linker.checkpoint_description = "At the top of Golden Clough the path divides. Ignore the eroded cobbled path descending to your
    right (heading for a huge pile of stones) and take the higher path that remains level and follows the
    top of the clough towards the top of Ringing Roger. At the top of Ringing Roger the path passes
    between a prominent cairn approx. 50m away on your left, and a closer pair of cairns on your right.
    Here the path narrows and bears off left heading for Ollerbrook Clough. Around the rim of Ollerbrook
    Clough the path becomes quite narrow. At the far side, the path forks. Take the left fork - eroded and
    slightly uphill. (Though the right fork joins up again a few hundred metres further on) and follow the
    path over Rowland Cote Moor. Keep to the edge and ignore any paths heading left into the interior, or
    right down into the valley. More steep and airy views! Eventually the path dips down and crosses the
    stream at the top of Jagger's Clough."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '9'
    linker.position_in_route = '9'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '21.6') do |linker|
    linker.checkpoint_description = "Shortly after crossing Jagger's Clough, you'll notice a broken stone wall appearing on your right. This
    continues for approx. 300m until it disappears again. Shortly after the wall disappears keep following
    the path, bearing right where necessary, until you begin to descend and reach a short rocky step
    about 5ft high. It's easy but take care. After the step the path continues to descend, curving round to
    the right across Crookstone Out Moor until you reach a wall with a metal gate. This wall marks a
    distinct boundary between heather moorland and the grassy upland pasture on Crookstone Hill."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '10'
    linker.position_in_route = '10'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '22.9') do |linker|
    linker.checkpoint_description = "Pass through the gate and follow the path downhill, heading for two distinct trees. At the trees the
    path splits. Here there is a signpost and a stone way-marker too! Take the path to the left for Hope
    Cross. (If you go straight on you'll come to a locked gate near Crookstone Barn and have to backtrack). 
    The path descends to join a broad rocky track at a gate. Turn right and follow the track,
    going straight on at a crossroads, until you reach the tall stone pillar of Hope Cross at SK 161 874."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '11'
    linker.position_in_route = '11'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '24.9') do |linker|
    linker.checkpoint_description = "From here, you'll see the summit of Win Hill up ahead on the horizon - keep walking in this direction.
    Initially follow the bridleway which leads you to the wood-line. Just at this point, you'll see a footpath
    that skirts along the wood-line, with a wire fence on the left and a stone wall on the right. For the
    easiest line, follow this for the next mile or so. Where the track very clearly deviates off and up
    rightwards towards the summit of Win Hill, leave the wood-line and head for Win Hill. As you get to
    the foot of Win Hill you'll come to a fork: take the high path leftwards for the hill top."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '12'
    linker.position_in_route = '12'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '28.7') do |linker|
    linker.checkpoint_description = "Follow the summit top on and down the other side, and down a steep path, and into the woods
    ahead. Just where the ground shallows out you will shortly come to a metal kissing gate. Turn right
    here taking the footpath so that a fence is immediately on your right and a stone wall will be on your
    left. At this kissing gate there will be a marshal waiting to take your number! A very muddy path will
    bring you down to a patch of grass, a stone wall opposite and you'll see a signpost pointing you left in
    the direction of Thornhill. Follow this, down a bit and right through gate and then down the path with a
    wall on your right hand side. This brings you to a cross paths, where there is an old moss-covered
    signpost. Take the left turn here headed for Yorkshire Bridge. This path spits you out onto the
    Thornhill Trail. Turn left and stay on this until you come to the dam wall at the head of Ladybower
    Reservoir. Turn right along here to the A6013 main road."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '13'
    linker.position_in_route = '13'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '32.2') do |linker|
    linker.checkpoint_description = "Cross over the road and up a footpath. Continue up through the woods until you find yourself in a
    clearing beneath some power cables, where you will need to turn right. (Do not be tempted to veer off
    up through the woods). Follow the well marked path under the power lines and then let the path lead
    you round to the left and up hill with the fence on your right. The path will shortly lead you over the
    fence and you will continue on this path (initially with a wall on your left) all the way to the top of
    Bamford Edge. As you get out the woods, and close to the edge, you will see Win Hill over to the left
    now and you will soon see that the path splits. Continue on the left fork, through a stone wall until you
    are at the top of the edge itself (where there will be a marshal to meet you)."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '14'
    linker.position_in_route = '14'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '33.6') do |linker|
    linker.checkpoint_description = "Turn right and head along the top of the edge so that the moor is on your left and the rocks (and
    super view) is off to your right, heading to Great Tor now with a very obvious path to lead you there.
    Continue onwards until you see some rocks up to your left with a path of sorts that will lead you there.
    At this spot you can also expect to meet the next marshal."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '15'
    linker.position_in_route = '15'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '34.9') do |linker|
    linker.checkpoint_description = "You'll meet the marshal here, and look over in the direction of Stanage Edge. All you will see is a sea
    of heather and a load of fern too. And hopefully, without looking too hard, you will also see another
    marshal. They will point out the merest of paths that exists (usually on a Strava heatmap only). Make
    your way down in a NW direction towards the apex of two collapsed and dilapidated walls where you
    will meet another marshal. Form here the path continues in the same vague way down hill to another
    marshal, and then up-hill towards Stanage Edge"
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '16'
    linker.position_in_route = '16'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '36.3') do |linker|
    linker.checkpoint_description = "Meet the marshal at Crow Chin and make your way up to the left of the rocks and onto the main
    track. Turn right along the main track, with the rocks down to your right now. You'll walk past the trig
    point at High Neb (a white pillar abut 1.3m high) and a couple of hundred meters later you will see a 
    path leading down to the left, initially to a stone shelter. Follow this path, which could be muddy, down
    the hill and away from Stanage Edge. About 800m on and the path will rise up towards the remains of
    stone wall and another path. Turn left along this path, keeping the wall/fence to your left. This path
    and wall will lead you round and over a broken down wall, and then on to a small plantation. Walk
    around the plantation keeping it to your left. You'll then see the path snaking down through and past
    some temporary grouse butts (look like green fence panels). Follow this down, cross the stream and
    follow the path round to the left, to a small reservoir, with a marshal, and to the flattest, most-even,
    and most welcome path in the world!"
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '17'
    linker.position_in_route = '17'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '39.6') do |linker|
    linker.checkpoint_description = "Follow this path now, through some metal gates, staying level and never leaving it, until you meet the
    road almost 2.5Km later. Turn left down the road for about 500m more and where there is reservoir
    head-wall to your right, and a foot path leading through the plantation, you will meet a marshal."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '18'
    linker.position_in_route = '18'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '42.5') do |linker|
    linker.checkpoint_description = "Follow this path down and round to the left going past an underground reservoir. Past some houses,
    and then to a metal gate. Here you need to turn left (don't go on to the big trail ahead). Go a few
    meters along a footpath heading back into the woods. By a tree on your left the path goes over the
    wall via some stone steps. Follow this path up through the woods, over a wall and on past the farm
    on your left. This will bring you out onto Soughley Lane. Continuue over the road and along the very
    obvious and, easy-going path called the Redmires Conduit. Follow this now for 2.5Km until you get to
    Blackbrook Road. Here you will see some playing fields opposite, continue over the road and through
    these fields. The path leads you past some play areas and up to some high wire-fences. Follow the
    path so it leads you with these sports pitches on your right."
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '19'
    linker.position_in_route = '19'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '46') do |linker|
    linker.checkpoint_description = "When you get to Crimicar lane, turn left. At the Shiny Sheff, turn right onto the Redmires Road and
    follow this down all the way to the shops at Crosspool. In Crosspool, juust before the zebra crossing,
    take the right turn along Selbourrne Rd and follow this to the A57. Follow this down now all the way to
    the University and to the University Arms. Well done!"
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '20'
    linker.position_in_route = '20'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '51.6 ') do |linker|
    linker.checkpoint_description = "Finish!"
    linker.advised_time = 20
    linker.route_id = '1'
    linker.checkpoint_id = '21'
    linker.position_in_route = '21'
end
print'.'


######################################################## route 2 ########################################################

RoutesAndCheckpointsLinker.create(distance_from_start: '0') do |linker|
    linker.checkpoint_description = "Head left up Marys Lane, under the railway bridge, and past the Rambler Inn. Go past the visitor
    centre on your right, and then look for the public footpath on your right just before the white houses
    that will be on your left. (If you walk as far as the church - you've gone too far!) Head down this path
    over the foot bridge and directly on through the metal gate heading in the same direction, with the
    hedgerow on your left. Continue through Ollerbrook Booth (and farm) and follow signs for the youth
    hostel. Keep going in this direction with the hills up to your left and the road down to your right. At no
    point will this path (later track) lead you to the road - just keep going in this same direction until the
    path leads you to a driveway with a farm opposite and a cattle grid down to your left. There will also
    be a sign pointing you to YHA Edale Activity Centre. Head on up there to the youth hostel."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '22'
    linker.position_in_route = '1'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '2.9') do |linker|
    linker.checkpoint_description = "You will see a very clear foot path marked taking you onwards. Follow this up and then down to the
    right and over the stream. Follow this path with the wall on your right and along to a stream crossing
    just above Clough Farm. Cross over that stream and take the left hand path. This will lead you over
    another stream, and then steeply up hill with a wall on your right. Keep going until you meet a very
    obvious bridleway. At the bridleway, keep on going up. This will take you up hill and then down hill to
    Jaggers Clough. Ford the stream at the bottom and continue onwards and upwards along the same
    bridleway. Keep going until you have crested this hill, through a metal gate. Just over the brow of the
    hill you will be at a cross roads of very obvious bridleways, and just in front of you will be the forestry
    block. Take the right turn here heading Hope Cross where there will be a marshal waiting to take your
    number."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '23'
    linker.position_in_route = '2'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '5.8') do |linker|
    linker.checkpoint_description = "From here, you'll see the summit of Win Hill up ahead on the horizon - keep walking in this direction.
    Initially follow the bridleway which leads you to the wood-line. Just at this point, you'll see a footpath
    that skirts along the wood-line, with a wire fence on the left and a stone wall on the right. For the
    easiest line, follow this for the next mile or so. Where the track very clearly deviates off and up
    rightwards towards the summit of Win Hill, leave the wood-line and head for Win Hill. As you get to
    the foot of Win Hill you'll come to a fork: take the high path leftwards for the hill top."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '12'
    linker.position_in_route = '3'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '9.6') do |linker|
    linker.checkpoint_description = "Follow the summit top on and down the other side, and down a steep path, and into the woods
    ahead. Just where the ground shallows out you will shortly come to a metal kissing gate. Turn right
    here taking the footpath so that a fence is immediately on your right and a stone wall will be on your
    left. At this kissing gate there will be a marshal waiting to take your number! A very muddy path will
    bring you down to a patch of grass, a stone wall opposite and you'll see a signpost pointing you left in
    the direction of Thornhill. Follow this, down a bit and right through gate and then down the path with a
    wall on your right hand side. This brings you to a cross paths, where there is an old moss-covered
    signpost. Take the left turn here headed for Yorkshire Bridge. This path spits you out onto the
    Thornhill Trail. Turn left and stay on this until you come to the dam wall at the head of Ladybower
    Reservoir. Turn right along here to the A6013 main road."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '13'
    linker.position_in_route = '4'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '13.1') do |linker|
    linker.checkpoint_description = "Cross over the road and up a footpath. Continue up through the woods until you find yourself in a
    clearing beneath some power cables, where you will need to turn right. (Do not be tempted to veer off
    up through the woods). Follow the well marked path under the power lines and then let the path lead
    you round to the left and up hill with the fence on your right. The path will shortly lead you over the
    fence and you will continue on this path (initially with a wall on your left) all the way to the top of
    Bamford Edge. As you get out the woods, and close to the edge, you will see Win Hill over to the left
    now and you will soon see that the path splits. Continue on the left fork, through a stone wall until you
    are at the top of the edge itself (where there will be a marshal to meet you)."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '14'
    linker.position_in_route = '5'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '14.5') do |linker|
    linker.checkpoint_description = "Turn right and head along the top of the edge so that the moor is on your left and the rocks (and
    super view) is off to your right, heading to Great Tor now with a very obvious path to lead you there.
    Continue onwards until you see some rocks up to your left with a path of sorts that will lead you there.
    At this spot you can also expect to meet the next marshal."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '15'
    linker.position_in_route = '6'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '15.8') do |linker|
    linker.checkpoint_description = "You'll meet the marshal here, and look over in the direction of Stanage Edge. All you will see is a sea
    of heather and a load of fern too. And hopefully, without looking too hard, you will also see another
    marshal. They will point out the merest of paths that exists (usually on a Strava heatmap only). Make
    your way down in a NW direction towards the apex of two collapsed and dilapidated walls where you
    will meet another marshal. Form here the path continues in the same vague way down hill to another
    marshal, and then up-hill towards Stanage Edge"
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '16'
    linker.position_in_route = '7'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '17.2') do |linker|
    linker.checkpoint_description = "Meet the marshal at Crow Chin and make your way up to the left of the rocks and onto the main
    track. Turn right along the main track, with the rocks down to your right now. You'll walk past the trig
    point at High Neb (a white pillar abut 1.3m high) and a couple of hundred meters later you will see a 
    path leading down to the left, initially to a stone shelter. Follow this path, which could be muddy, down
    the hill and away from Stanage Edge. About 800m on and the path will rise up towards the remains of
    stone wall and another path. Turn left along this path, keeping the wall/fence to your left. This path
    and wall will lead you round and over a broken down wall, and then on to a small plantation. Walk
    around the plantation keeping it to your left. You'll then see the path snaking down through and past
    some temporary grouse butts (look like green fence panels). Follow this down, cross the stream and
    follow the path round to the left, to a small reservoir, with a marshal, and to the flattest, most-even,
    and most welcome path in the world!"
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '17'
    linker.position_in_route = '8'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '20.5') do |linker|
    linker.checkpoint_description = "Follow this path now, through some metal gates, staying level and never leaving it, until you meet the
    road almost 2.5Km later. Turn left down the road for about 500m more and where there is reservoir
    head-wall to your right, and a foot path leading through the plantation, you will meet a marshal."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '18'
    linker.position_in_route = '9'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '23.4') do |linker|
    linker.checkpoint_description = "Follow this path down and round to the left going past an underground reservoir. Past some houses,
    and then to a metal gate. Here you need to turn left (don't go on to the big trail ahead). Go a few
    meters along a footpath heading back into the woods. By a tree on your left the path goes over the
    wall via some stone steps. Follow this path up through the woods, over a wall and on past the farm
    on your left. This will bring you out onto Soughley Lane. Continuue over the road and along the very
    obvious and, easy-going path called the Redmires Conduit. Follow this now for 2.5Km until you get to
    Blackbrook Road. Here you will see some playing fields opposite, continue over the road and through
    these fields. The path leads you past some play areas and up to some high wire-fences. Follow the
    path so it leads you with these sports pitches on your right."
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '19'
    linker.position_in_route = '10'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '26.9') do |linker|
    linker.checkpoint_description = "When you get to Crimicar lane, turn left. At the Shiny Sheff, turn right onto the Redmires Road and
    follow this down all the way to the shops at Crosspool. In Crosspool, juust before the zebra crossing,
    take the right turn along Selbourrne Rd and follow this to the A57. Follow this down now all the way to
    the University and to the University Arms. Well done!"
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '20'
    linker.position_in_route = '11'
end
print'.'
RoutesAndCheckpointsLinker.create(distance_from_start: '32.5') do |linker|
    linker.checkpoint_description = "Finish!"
    linker.advised_time = 20
    linker.route_id = '2'
    linker.checkpoint_id = '21'
    linker.position_in_route = '12'
end
print'.'






#Account for walker
User.where(email:'walker@test.com').first_or_create(name:'testWalker', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'1')
print'.'

Participant.where(participant_id:'1001').first_or_create(participant_id:'1001', checkpoints_id: '1', user_id: '1', status: 'none', rank: '1', pace: 'On Pace.', routes_id: '1', event_id: '1')
print'.'

CheckpointTime.create(times: '2022-05-06 14:05:00.000000000 +0000', checkpoint_id: '1', participant_id: '1')

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
Marshall.where(marshal_id:'2001').first_or_create(marshal_id:'2001', user_id: '2', checkpoints_id: '2')
# Marshall.where(marshal_id:'2001').update(checkpoints_id: nil)
print'.'
MarshalShift.where(status: "Started").first_or_create(status: "Started", current_time: '2022-06-6 14:00:00.000000000 +0000', marshalls_id: '1')
"current_time"
#Account for Admin
User.where(email:'admin@test.com').first_or_create(name:'testAdmin', mobile:'00000000000', password:'Testtest1!', password_confirmation:'Testtest1!',tag_id:'3')
print'.'

#Print statment
puts ""
puts "----------------------------------------Seeds Finished----------------------------------------"

if  User.where(name:'testMarshal', mobile:'00000000000',tag_id:'2')
    puts "Created Marshal User Successfully"
    puts "-------------------------------------"
else
    puts "Created Marshal User Fail"
    puts "-------------------------------------"
end

if Marshall.where(marshal_id:'2001',  user_id: '2').first
    puts "Created Marshall Successfully"
    puts "-------------------------------------"
else
    puts "Created Marshall Fail"
    puts "-------------------------------------"
end

puts "----------------------------------------Seeds Finished----------------------------------------"