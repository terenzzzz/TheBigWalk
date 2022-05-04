
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
if Route.where(name: '50km',event_id: '1').first
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
    puts "created 10 Pickups"
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
if  User.where(email:'marshal@test.com',name:'testMarshal', mobile:'00000000000',tag_id:'2')
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

#10 Marshals
if User.where(tag_id: '2',  id: '111').first
    puts "Created 10 Marshall User Successfully"
    puts "-------------------------------------"
else
    puts "Created 10 Marshall User Fail"
    puts "-------------------------------------"
end

if Marshall.where(users_id: '111').first
    puts "Created 10 Marshalls Successfully"
    puts "-------------------------------------"
else
    puts "Created 10 Marshalls Fail"
    puts "-------------------------------------"
end

#3-102 User
if User.where(id: 101).first
    puts "created 3-102 User Successfully"
    puts "-------------------------------------"
else
    puts "created 3-102 User Fail"
    puts "-------------------------------------"
end

if Participant.where(user_id: 101).first
    puts "created 1002-1999 Participant Successfully"
    puts "-------------------------------------"
else
    puts "created 1002-1999 User Fail"
    puts "-------------------------------------"
end

#CheckpointTime
if CheckpointTime.where(checkpoint_id: 5).first
    puts "created CheckpointTime Successfully"
    puts "-------------------------------------"
else
    puts "created 1002-1999 User Fail"
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

puts "------------------Seeds Finished------------------------"