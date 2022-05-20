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
    let!(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1, donate_link:'/')}
    let!(:opted_in) { OptedInLeaderboard.where(user:user1).first_or_create(opted_in: true) }
    
    before do
        login_as user1
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        find(:css, '.i.bi.bi-person-circle.display-6').click
        click_on 'Profile'
        
    end

    context 'As a logged in walker' do
        specify "I can go to my donate link" do
            click_on 'Your Donation Page'
            expect(page.current_path).to eql("/walkers/#{user1.id}")
        end
    
        specify "I can edit name of my profile" do
            click_on 'Edit Your Account'
            fill_in 'Name', with: 'Test'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
            
        end

        specify "I can edit avatar of my profile" do
            click_on 'Edit Your Account'
            attach_file 'Profile Picture', "#{Rails.root}/spec/fixtures/images/test.png"
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can edit description of my profile" do
            click_on 'Edit Your Account'
            fill_in 'Tell The World Anything!',with: 'Hello'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end


        specify "I can edit Mobile of my profile" do
            click_on 'Edit Your Account'
            fill_in 'Mobile', with: '12345678910'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can set my donate link" do
            click_on 'Edit Your Account'
            fill_in 'Link To Your Donation Page', with: '/'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can set my walker number" do
            click_on 'Edit Your Account'
            fill_in 'Walker Number', with: '1999'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can opt out leaderboard" do
            click_on 'Edit Your Account'
            uncheck 'opted_in'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can opt in leaderboard" do
            click_on 'Edit Your Account'
            check 'opted_in'
            click_button'Update User'
            expect(page).to have_content 'Profile successfully updated.'
        end

        specify "I can sign out" do
            click_on 'Sign out'
            
            expect(page).to have_content 'Signed out successfully.'
        end

        specify "I can Delete Account" do
            click_on 'Edit Your Account'
            click_on 'Delete Account'
            click_on 'Yes'
            expect(page.current_path).to eql('/users/sign_in')
        end
    end

end
