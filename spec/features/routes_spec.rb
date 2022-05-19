require 'rails_helper'

describe 'routes' do
    let(:tag1) { FactoryBot.create(:tag, :admin) }
    let(:user1) { FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1) }

    context 'As an admin' do
        before do
            login_as user1
        end

        specify "I can create a route" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            expect(page).to have_content '50km'
        end

        specify "I can create a route later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Routes"
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            expect(page).to have_content '50km'
        end

        specify "I cant create a route when course length is a letter" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: 'a'
            click_button 'Create'
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I can create multiple routes" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '30km'
            fill_in 'Course Length (Km):', with: '30'
            click_button 'Create'
            expect(page).to have_content('50km' && '30km') 
        end

        specify "I cant create a route where it has the same name for the same event" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I can edit a route after making it" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_link 'Edit'
            fill_in 'Route Name:', with: '30km'
            click_button 'Save'
            expect(page).to have_content '30km'
        end

        specify "I can delete a route after making it" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_link 'Edit'
            expect{click_on 'Delete'}.to change(Route, :count)
        end

        specify "I can edit a route later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Routes"
            click_link 'Edit'
            fill_in 'Route Name:', with: '30km'
            click_button 'Save'
            expect(page).to have_content '30km'
        end

        specify "I can delete a route later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Routes"
            click_link 'Edit'
            expect{click_on 'Delete'}.to change(Route, :count)
        end
    end
end