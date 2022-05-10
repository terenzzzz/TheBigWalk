require 'rails_helper'

describe 'log_in' do
    let(:tag1) { Tag.where(name:'Walker').first_or_create(name:'Walker') }
    let(:user1) {  User.create(name:'test', email: 'test@test.com', mobile:'00000000000',  password: 'Testtest1!', password_confirmation: 'Testtest1!', tag_id: tag1.id)}
    


    specify 'I cannot access the walker ' do
        visit '/pages/pick_event'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    # Test Log in
    specify 'I can log in as a Walker' do
        visit '/users/sign_in'
        fill_in "Email", with: user1.email
        fill_in "Password", with: user1.password
        click_button "Log In"
        expect(page.current_path).to eql('/pages/pick_event')
        expect(page).to have_content 'Signed in successfully.'
    end
end
