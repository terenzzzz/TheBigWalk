require 'rails_helper'

describe 'checkpoints' do
    let(:user1)      { User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest') }

    context 'As an admin' do
        before do
            login_as user1
        end

        specify "I can create a checkpoint when creating a new event" do
            visit "/admins"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Course Length (km):', with: '50'
            click_button 'Create'
            click_link 'Create New Checkpoint'
            fill_in 'Checkpoint Name:', with: 'Hope Cross'
            fill_in 'Checkpoint Distance (km):', with: '1.5'
            fill_in 'OS Grid Reference:', with: 'SK12345'
            fill_in 'Advised Time (mins):', with: '1'
            fill_in 'Checkpoint Description:', with: 'A Checkpoint'
            click_button 'Save'
            expect(page).to have_content 'Hope Cross'
        end

        specify "I can edit a checkpoint when creating a new event" do
            visit "/admins"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Course Length (km):', with: '50'
            click_button 'Create'
            click_link 'Create New Checkpoint'
            fill_in 'Checkpoint Name:', with: 'Hope Cross'
            fill_in 'Checkpoint Distance (km):', with: '1.5'
            fill_in 'OS Grid Reference:', with: 'SK12345'
            fill_in 'Advised Time (mins):', with: '1'
            fill_in 'Checkpoint Description:', with: 'A Checkpoint'
            click_button 'Save'
            click_link 'Edit'
            fill_in 'Checkpoint Name:', with: 'Hope Hill'
            click_button 'Save'
            expect(page).to have_content 'Hope Hill'
        end

        specify "I can view checkpoints from the main admin page" do
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            click_link 'Manage Checkpoints'
            expect(page).to have_content 'Checkpoints'
        end
        
        specify "I can view checkpoints from the event info page" do
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            click_link 'Event Info'
            click_link 'Manage Checkpoints'
            expect(page).to have_content 'Checkpoints'
        end

        specify "I can add checkpoints after an event has been created" do
            skip
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            click_link 'Manage Checkpoints'
            click_link 'Create New Checkpoint'
            fill_in 'Checkpoint Name:', with: 'Hope Cross'
            fill_in 'Checkpoint Distance (km):', with: '1.5'
            fill_in 'OS Grid Reference:', with: 'SK12345'
            fill_in 'Advised Time (mins):', with: '1'
            fill_in 'Checkpoint Description:', with: 'A Checkpoint'
            click_button 'Save'
            expect(page).to have_content 'Hope Cross'
        end

        
        specify "I can edit checkpoints after an event has been created" do
            skip
            FactoryBot.create :event
            visit "/admins"
            click_link 'Manage My Events'
            click_link 'Select'
            click_link 'Manage Checkpoints'
            click_link 'Edit'
            fill_in 'Checkpoint Name:', with: 'Hope Hill'
            click_button 'Save'
            expect(page).to have_content 'Hope Hill'
        end
    end
end