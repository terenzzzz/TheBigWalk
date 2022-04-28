require 'rails_helper'

describe 'walker' do
    let(:tag1) { Tag.create(name:'Walker') }
    let(:user1)  { User.create(name:'test', email: 'test@test.com', mobile:'0000',  password: 'testtest', tag:tag1) }

    # specify 'I can log in as a Walker' do
    #     visit '/users/sign_in'
    #     fill_in "Email", with: user1.email
    #     fill_in "Password", with: user1.password
    #     click_button "Log In"
    #     expect(page).to have_content 'Signed in successfully.'
    # end

    before do
        # puts user1.id
        # puts user1.tag.name
        # puts user1.tag_id
        # puts tag1.id
        login_as user1
    end

    specify 'I can Check the Checkpoint Info' do
        visit '/walkers'
        click_button 'Check Point Information'

        expect(page.current_path).to eql('/walkers/checkpoint_info')
    end

end
