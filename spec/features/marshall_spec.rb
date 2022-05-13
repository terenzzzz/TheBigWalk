require 'rails_helper'

describe 'checkpoints' do
    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }

    let!(:checkpoint1) { Checkpoint.create(name: "test1", os_grid: 'SK331896', event: event)}
    let!(:linker1) { RoutesAndCheckpointsLinker.create(distance_from_start: '10',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint1,position_in_route: '1')}
    
    let!(:checkpoint2) { Checkpoint.create(name: "test2", os_grid: 'SK331896', event: event)}
    let!(:linker2) { RoutesAndCheckpointsLinker.create(distance_from_start: '50',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint2,position_in_route: '2')}
    
    let!(:checkpoint3) { Checkpoint.create(name: "test3", os_grid: 'SK331896', event: event)}
    let!(:linker3) { RoutesAndCheckpointsLinker.create(distance_from_start: '100',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint3,position_in_route: '3')}
    
    let(:tag1) { FactoryBot.create(:tag, :marshall) }
    let(:user1) { FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1) }
    let!(:walker1) { FactoryBot.create(:participant)}

    context 'As a marshal' do
         before do
             login_as user1
         end

         #Tom will finish all this later

#         specify "I can sign in to an event"
#             visit '/'
#             click_on event.name
#             expect(page).to have_content 'Choose Your Current Checkpoint'
#             #go to choose_event

#         specify "I can sign in to a checkpoint"
#             visit "/"
#             #go to add_shift page

#         specify "I can change my checkpoint"
#             visit "/"
#             click_link 'Change Checkpoint'

#         specify "I can't re-sign in to the same checkpoint"
#             visit "/"
#             click_link 'Change Checkpoint'
        
#         specify "I can view incoming walkers"
#             visit "/"
#             click_link 'View Incoming Walkers'
        
#        #This one is old and definitely needs editing
#        specify "I can checkin a walker to my checkpoint" do
#            FactoryBot.create :participant
#            visit "/"
#            click_link 'Staff'
#            click_link 'Checkin Walkers'
#            fill_in 'Walker Number:', with: '1'
#            click_button 'Checkin Walker'
#            expect(page).to have_content 'Marshal ID'
#        end

#        specify "I can't check in a walker that has alread passed"
#            visit "/"
#            click_link 'Checkin Walkers'

#        specify "I can't check in a walker that hasn't reached the previous checkpoint"
#            visit "/"
#            click_link 'Checkin Walkers'

#        specify "I can't check in a walker that doesn't exist"
#            visit "/"
#            click_link 'Checkin Walkers'

#        specify "I can't check in a walker that has alread passed"
#            visit "/"
#            click_link 'Checkin Walkers'

#        specify "I can pause my shift"
#            visit "/"
#            click_link 'End Marshal Shift'
#            click_link 'Pause Marshalling'

#        specify "I can resume my shift"
#            visit "/"
#            click_link 'End Marshal Shift'
#            click_link 'Resume Marshal Shift'
        
#         specify "I can end my shift for the day"
#             visit "/"
#             click_link 'End Marshal Shift'
#             click_link 'End For The Day'

         #There probably is more to add but I can't think of them right now
         #Again - THESE ARE MOST CERTAINLY NOT DONE, I will do it in the next couple of days - Tom

    end

end