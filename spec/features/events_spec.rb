require 'rails_helper'

describe 'events' do
    let(:user1)      { User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest') }

    context 'As an admin' do
        before do
            login_as user1
        end

        specify "I can create an event" do
            visit "/admins"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Course Length (km):', with: '50'
            click_button 'Create'
            visit "/events"
            expect(page).to have_content 'The Big Walk'
        end

        specify "I can select an event" do
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            expect(page).to have_content 'Event Info'
        end

        specify "I can edit an event" do
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            click_link 'Event Info'
            fill_in 'Event Name:', with: 'The Small Walk'
            click_button 'Save'
            visit "/events"
            expect(page).to have_content 'The Small Walk'
        end

        specify "I can delete an event" do
            skip
            visit "/admins"
            click_link 'Manage My Events'
            click_button 'Select'
            click_button 'Event Info'
            click_button 'Delete'
        end
    end
end