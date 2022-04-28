require 'rails_helper'

describe 'walker' do
    let(:tag1) { Tag.create(name:'Walker') }
    let(:user1)  { User.create(name:'test', email: 'test@test.com', mobile:'0000',  password: 'testtest', password_confirmation: 'testtest') }

    before do
        login_as user1
    end


end
