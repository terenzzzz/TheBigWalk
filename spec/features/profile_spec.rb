require 'rails_helper'

describe 'profile' do
    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }

    let!(:checkpoint1) { Checkpoint.create(name: "test1", os_grid: 'SK331896', event: event)}
    let!(:linker1) { RoutesAndCheckpointsLinker.create(distance_from_start: '10',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint1,position_in_route: '1')}
    
    let!(:checkpoint2) { Checkpoint.create(name: "test2", os_grid: 'SK331896', event: event)}
    let!(:linker2) { RoutesAndCheckpointsLinker.create(distance_from_start: '50',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint2,position_in_route: '2')}
    
    let!(:checkpoint3) { Checkpoint.create(name: "test3", os_grid: 'SK331896', event: event)}
    let!(:linker3) { RoutesAndCheckpointsLinker.create(distance_from_start: '100',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint3,position_in_route: '3')}
    

    let!(:tag1) { FactoryBot.create(:tag) }
    let!(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}
    let!(:participant) {FactoryBot.create(:participant, user:user1, route:route, checkpoint:checkpoint1, event:event)}
    let!(:opted_in) { OptedInLeaderboard.where(user:user1).first_or_create(opted_in: true) }

    before do
        login_as user1
    end

    context 'As a logged in user' do
    
        specify "I can edit name of my profile",js:true do
            visit "/"
            click_on event.name
            click_on route.name
            
            # save_and_open_screenshot
            fill_in 'Name', with: 'Test'
            click_button'Update User'
            expect(page.current_path).to eql('/profile')
        end

        specify "I can edit avatar of my profile" do
            visit "/profile"
            click_link 'Edit'
            attach_file 'avatar', "#{Rails.root}/spec/fixtures/images/test.png"
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can edit description of my profile" do
            visit "/profile"
            click_link 'Edit'
            fill_in 'Description', with: 'Hello'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can edit Mobile of my profile" do
            visit "/profile"
            click_link 'Edit'
            fill_in 'Mobile', with: '8888888888'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end
    end

end
