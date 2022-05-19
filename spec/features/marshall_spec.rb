require 'rails_helper'

# describe 'checkpoints' do
describe 'marshal' do
    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }

    let!(:checkpoint1) { Checkpoint.create(name: "test1", os_grid: 'SK331896', event: event)}
    let!(:linker1) { RoutesAndCheckpointsLinker.create(distance_from_start: '10',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint1,position_in_route: '1')}
    
    let!(:checkpoint2) { Checkpoint.create(name: "test2", os_grid: 'SK331896', event: event)}
    let!(:linker2) { RoutesAndCheckpointsLinker.create(distance_from_start: '50',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint2,position_in_route: '2')}
    
    let!(:checkpoint3) { Checkpoint.create(name: "test3", os_grid: 'SK331896', event: event)}
    let!(:linker3) { RoutesAndCheckpointsLinker.create(distance_from_start: '100',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint3,position_in_route: '3')}
    
    let!(:tag1) { Tag.create(name:"Marshal") }
    let!(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}
    let!(:marshal1) {Marshall.create(marshal_id: '2009', checkpoints_id: checkpoint1.id, user_id: user1.id)}

    let!(:tag2) { FactoryBot.create(:tag) }
    let!(:user2) {  FactoryBot.create(:user, name:'test2', email: 'test2@test.com', mobile:'11111111111', tag: tag2)}
    let!(:opted_in) { OptedInLeaderboard.where(user:user2).first_or_create(opted_in: true) }
    # let!(:marshal)

    before do
        login_as user2
        visit "/"
        click_on event.name
        click_on route.name
        find(:css, '.i.bi.bi-person-circle.display-6').click
        click_on 'Profile'
        click_on 'Sign Out'
        login_as user1
    end
        
    context 'As a marshal' do
        #pass
        specify "I can sign in to an event" do
           visit "/"
           click_on event.name

           expect(page).to have_content 'Start Your Shift'
        end

        #pass
        specify "I can sign in to a checkpoint" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name

            expect(page).to have_content 'Walkers Falling Behind'
        end

        #pass
        specify "I can change my checkpoint" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_on 'Change Checkpoint'
            click_on checkpoint2.name

            expect(page).to have_content checkpoint2.name
        end

        #pass
        specify "I can't re-sign in to the same checkpoint" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_link 'Change Checkpoint'
            click_on checkpoint1.name

            expect(page).to have_content 'Change Checkpoint'
        end
        
        #pass
        specify "I can view incoming walkers" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_link 'View Incoming Walkers'

            expect(page).to have_content 'Incoming Walkers'
        end
        
        specify "I can checkin a walker to my checkpoint" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_link 'Checkin Walkers'
            fill_in 'Walker Number:', with: user2.participant_id
            click_button 'Checkin Walker'

            expect(page).to have_content 'Marshal ID'
        end

        # specify "I can't check in a walker that has already passed" do
        #     visit "/"
        #     click_link 'Checkin Walkers'
        # end

        # specify "I can't check in a walker that hasn't reached the previous checkpoint" do
        #     visit "/"
        #     click_link 'Checkin Walkers'
        # end

        # specify "I can't check in a walker that doesn't exist" do
        #     visit "/"
        #     click_link 'Checkin Walkers'
        # end 

        # specify "I can't check in a walker that has alread passed" do
        #     visit "/"
        #     click_link 'Checkin Walkers'
        # end

        #pass
        specify "I can pause my shift" do
            visit '/'
            click_on event.name
            click_on checkpoint1.name
            click_on 'End Marshal Shift'
            click_on 'Pause Marshalling'

            expect(page).to have_content 'Marshalling Paused'
        end

        #pass
        specify "I can resume my shift" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_on 'End Marshal Shift'
            click_on 'Pause Marshalling'
            click_on 'Resume Marshal Shift'

            expect(page).to have_content 'Marshalling Resumed'
        end

        #pass
        specify "I can end my shift for the day and make my own way home" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_on 'End Marshal Shift'
            click_on 'End For The Day'
            click_on 'Making My Own Way Home'

            expect(page.current_path).to eql('/users/sign_in')
        end

        #pass
        specify "I can end my shift for the day and Need Pick Up" do
            visit "/"
            click_on event.name
            click_on checkpoint1.name
            click_on 'End Marshal Shift'
            click_on 'End For The Day'
            click_on 'I Need Picking Up'

            expect(page).to have_content 'Pick up request successful.'
        end

    end

end