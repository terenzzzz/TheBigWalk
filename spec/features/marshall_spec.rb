require 'rails_helper'

describe 'checkpoints' do
    let(:user1)      { User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest') }

    context 'As a marshal' do
        before do
            login_as user1
        end

        specify "I can checkin a walker to my checkpoint" do
            FactoryBot.create :event
            FactoryBot.create :checkpoint
            FactoryBot.create :checkpoint, id: '2'
            FactoryBot.create :route
            FactoryBot.create :marshall
            FactoryBot.create :participant
            visit "/"
            click_link 'Staff'
            click_link 'Checkin Walkers'
            fill_in 'Walker Number:', with: '1'
            click_button 'Checkin Walker'
            expect(page).to have_content 'Marshal ID'
        end
    end

end