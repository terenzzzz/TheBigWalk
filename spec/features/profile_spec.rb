require 'rails_helper'

describe 'profile' do
    let(:tag1) { FactoryBot.create(:tag) }
    let(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}

    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }
    let!(:checkpoint1) { FactoryBot.create(:checkpoint, event: event) }
    let!(:checkpoint2) { FactoryBot.create(:checkpoint, event: event, name:'test') }
    let!(:checkpoint3) { FactoryBot.create(:checkpoint, event: event, name:'test1') }

    before do
        login_as user1
        
        OptedInLeaderboard.create(opted_in:true,user_id:user1)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint1, route: route, position_in_route: 1)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint2, route: route, position_in_route: 2)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint3, route: route, position_in_route: 3)
    end

    context 'As a logged in user' do
    
        specify "I can edit name of my profile" do
            visit "/profile/#{user1}/edit"
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
