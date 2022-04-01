require 'rails_helper'

describe 'log_in' do

    let(:user1)      {  User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')}


    
    specify 'I cannot access the walker index without logging in' do
        visit '/walkers'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    # Test Sign up
    context 'As a non signed in user' do
        specify 'I cannot sign up if password too short' do
            visit '/users/sign_up'
            fill_in "Email", with: 'a.n@email.com'
            fill_in "Password", with: 'pass'
            fill_in "Password confirmation", with: 'pass'
            click_button 'Sign up'
            expect(page).to have_content 'Password is too short (minimum is 8 characters)'
            expect(page).to_not have_content 'Welcome! You have signed up successfully.'
        end

        specify 'I cannot sign up if I use an invalid email' do
            visit '/users/sign_up'
            fill_in "Email", with: 'notavalidemail'
            fill_in "Password", with: 'password123!'
            fill_in "Password confirmation", with: 'password123!'
            click_button 'Sign up'
            expect(page).to have_content 'Email is invalid'
            expect(page).to_not have_content 'Welcome! You have signed up successfully.'
        end

        specify 'I cannot sign up if my password and confirmation password do not match' do
            visit '/users/sign_up'
            fill_in "Email", with: 'notavalidemail'
            fill_in "Password", with: 'password123!'
            fill_in "Password confirmation", with: 'password456!'
            click_button 'Sign up'
            expect(page).to have_content "Password confirmation doesn't match Password"
            expect(page).to_not have_content 'Welcome! You have signed up successfully.'
        end

        specify "I can sign up with a long password" do
            visit "/users/sign_up"
            fill_in "Email", with: 'a.n@email.com'
            fill_in "Password", with: '3fNPg6fqScrZs0m3'
            fill_in "Password confirmation", with: '3fNPg6fqScrZs0m3'
            click_button 'Sign up'
            expect(page).to have_content 'Welcome! You have signed up successfully.'
          end

        specify "I can sign up with a name, email, mobile, password" do
        visit "/users/sign_up"
        # upload file
        attach_file 'Add an avatar here', "#{Rails.root}/spec/fixtures/images/test.png"
        fill_in "Name", with: 'Beluga'
        fill_in "Email", with: 'a.n@email.com'
        fill_in "Mobile", with: '00000000000'
        fill_in "Password", with: '3fNPg6fqScrZs0m3'
        fill_in "Password confirmation", with: '3fNPg6fqScrZs0m3'
        click_button 'Sign up'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
        end 
    end


    # Test Log in
    specify 'I can log in as a Walker' do
        visit '/users/sign_in'
        fill_in "Email", with: user1.email
        fill_in "Password", with: user1.password
        click_button "Log in"
        expect(page).to have_content 'Signed in successfully.'
    end
end
