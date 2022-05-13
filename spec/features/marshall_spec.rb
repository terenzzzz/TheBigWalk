require 'rails_helper'

describe 'checkpoints' do
    let(:tag1) { FactoryBot.create(:tag, :marshall) }
    let(:user1) { FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1) }

    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }
    let!(:checkpoint1) { FactoryBot.create(:checkpoint, event: event, id: '1') }
    let!(:checkpoint2) { FactoryBot.create(:checkpoint, event: event, id: '2') }

    context 'As a marshal' do
        before do
            login_as user1

            RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint1, route: route, position_in_route: 1)
            RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint2, route: route, position_in_route: 2)
            RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint3, route: route, position_in_route: 3)
        end

        #Tom will finish all this later

        specify "I can sign in to an event"
            visit "/"
            #go to choose_event

        specify "I can sign in to a checkpoint"
            visit "/"
            #go to add_shift page

        specify "I can change my checkpoint"
            visit "/"
            click_link 'Change Checkpoint'

        specify "I can't re-sign in to the same checkpoint"
            visit "/"
            click_link 'Change Checkpoint'
        
        specify "I can view incoming walkers"
            visit "/"
            click_link 'View Incoming Walkers'
        
        #This one is old and definitely needs editing
        specify "I can checkin a walker to my checkpoint" do
            FactoryBot.create :participant
            visit "/"
            click_link 'Staff'
            click_link 'Checkin Walkers'
            fill_in 'Walker Number:', with: '1'
            click_button 'Checkin Walker'
            expect(page).to have_content 'Marshal ID'
        end

        specify "I can't check in a walker that has alread passed"
            visit "/"
            click_link 'Checkin Walkers'

        specify "I can't check in a walker that hasn't reached the previous checkpoint"
            visit "/"
            click_link 'Checkin Walkers'

        specify "I can't check in a walker that doesn't exist"
            visit "/"
            click_link 'Checkin Walkers'

        specify "I can't check in a walker that has alread passed"
            visit "/"
            click_link 'Checkin Walkers'

        specify "I can pause my shift"
            visit "/"
            click_link 'End Marshal Shift'
            click_link 'Pause Marshalling'

        specify "I can resume my shift"
            visit "/"
            click_link 'End Marshal Shift'
            click_link 'Resume Marshal Shift'
        
        specify "I can end my shift for the day"
            visit "/"
            click_link 'End Marshal Shift'
            click_link 'End For The Day'

        #There probably is more to add but I can't think of them right now
        #Again - THESE ARE MOST CERTAINLY NOT DONE, I will do it in the next couple of days - Tom

    end

end