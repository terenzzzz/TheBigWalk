require 'rails_helper'

describe 'events' do
    let(:tag1) { FactoryBot.create(:tag, :admin) }
    let(:user1) { FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1) }

    context 'As an admin' do
        before do
            login_as user1
        end

        specify "I can create an event" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            visit "/events"
            expect(page).to have_content 'The Big Walk'
        end

        specify "I cant create an event with the same name" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            visit "/events"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            #expect(page).to have_content 'Name has already been taken' 
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I cant create an event with an incorret phone number length" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '0'
            click_button 'Create'
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I cant create an event with an incorret phone number as letters" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: 'aaaaaaaaaaa'
            click_button 'Create'
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I can select an event when there is no route or checkpoint" do
            event = FactoryBot.create :event
            visit "/"
            click_on event.name
            expect(page).to have_content 'Switch Event'
        end

        specify "I can edit an event when there is no route or checkpoint" do
            event = FactoryBot.create :event
            FactoryBot.create(:branding, event: event)
            visit "/"
            click_on event.name
            click_link 'Event Info'
            fill_in 'Event Name:', with: 'The Small Walk'
            click_button 'Save'
            visit "/"
            expect(page).to have_content 'The Small Walk'
        end

        specify "I can delete an event when there is no route or checkpoint" do
            event = FactoryBot.create :event
            FactoryBot.create(:branding, event: event)
            visit "/"
            click_on event.name
            click_on('Event Info') 
            expect{click_on 'Delete'}.to change(Event, :count)
        end
    end
end