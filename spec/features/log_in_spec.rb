require 'rails_helper'
describe 'Security exercise' do

    let(:user1)      { User.create(email: 'user1@epigenesys.org.uk', password: 'Passwrd1', password_confirmation: 'Passwrd1') }


    
    specify 'I cannot access the walker index without logging in' do
        visit '/'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    specify 'I can log in as a Walker' do
        visit '/walkers'
        fill_in "Email", with: 'user1@epigenesys.org.uk'
        fill_in "Password", with: 'Passwrd1'
        click_button "Log in"
        expect(page).to have_content 'Signed in successfully.'
    end
end
