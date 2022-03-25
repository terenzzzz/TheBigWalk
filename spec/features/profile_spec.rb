require 'rails_helper'

describe 'profile' do
    let(:user1)      { User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest') }

    context 'As a logged in user' do

        before do
          login_as user1
        end
    
        specify "I can edit name of my profile" do
            visit "/profile"
            click_link 'Edit'
            fill_in 'Name', with: 'Test'
            click_button'Update User'
            expect(page).to have_content 'profile was successfully updated.'
          end

        specify "I can edit description of my profile" do
        visit "/profile"
        click_link 'Edit'
        fill_in 'Description', with: 'Hello'
        click_button'Update User'
        expect(page).to have_content 'profile was successfully updated.'
        end

        specify "I can edit Mobile of my profile" do
        visit "/profile"
        click_link 'Edit'
        fill_in 'Mobile', with: '8888888888'
        click_button'Update User'
        expect(page).to have_content 'profile was successfully updated.'
        end
    end

end
