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
    # let!(:marshal)

    before do
        login_as user1
    end
        
    context 'As a marshal' do
        # specify "I can sign in to an event" do
        #     visit "/"
        #     go to choose_event
        # end

        # specify "I can sign in to a checkpoint" do
        #     visit "/"
        #     #go to add_shift page
        # end

        # specify "I can change my checkpoint" do
        #     visit "/"
        #     click_on 'Change Checkpoint'
        # end

        # specify "I can't re-sign in to the same checkpoint" do
        #     visit "/"
        #     click_link 'Change Checkpoint'
        # end
        
        # specify "I can view incoming walkers" do
        #     visit "/"
        #     click_link 'View Incoming Walkers'
        # end
        
        # #This one is old and definitely needs editing
        # specify "I can checkin a walker to my checkpoint" do
        #     FactoryBot.create :event
        #     FactoryBot.create :checkpoint
        #     FactoryBot.create :checkpoint, id: '2'
        #     FactoryBot.create :route
        #     FactoryBot.create :marshall
        #     FactoryBot.create :participant
        #     visit "/"
        #     click_link 'Staff'
        #     click_link 'Checkin Walkers'
        #     fill_in 'Walker Number:', with: '1'
        #     click_button 'Checkin Walker'
        #     expect(page).to have_content 'Marshal ID'
        # end

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

        #fail
        specify "I can pause my shift" do
            visit '/'
            click_on event.name
            click_on checkpoint1
            click_on 'End Marshal Shift'
            click_on 'Pause Marshalling'
        end

        # #fail
        # specify "I can resume my shift" do
        #      visit "/"
        #      click_link 'End Marshal Shift'
        #      click_link 'Resume Marshal Shift'
        # end

        # #fail
        # specify "I can end my shift for the day and make my own way home" do
        #     visit "/"
        #     click_on 'End Marshal Shift'
        #     click_on 'End For The Day'
        #     click_on 'Making My Own Way Home'

        #     expect(page.current_path).to eql('/users/sign_in')
        # end

        # #fail
        # specify "I can end my shift for the day and Need Pick Up" do
        #     visit "/"
        #     click_on 'End Marshal Shift'
        #     click_on 'End For The Day'
        #     click_on 'I Need Picking Up'

        #     expect(page).to have_content 'Pick up request successful.'
        # end
        #There probably is more to add but I can't think of them right now
        #Again - THESE ARE MOST CERTAINLY NOT DONE, I will do it in the next couple of days - Tom

    end

end