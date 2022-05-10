require 'rails_helper'

describe 'walker' do
    let(:tag1) { FactoryBot.create(:tag) }
    let(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}

    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }
    let!(:checkpoint) { FactoryBot.create(:checkpoint, event: event) }

    before do
        login_as user1

        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint, route: route, position_in_route: 1)
    end

    specify 'I can Check the Checkpoint Info', js:true do
        visit '/'

        click_on event.name
        click_on route.name

        click_on 'Sign Up For Event'
        save_and_open_screenshot
        click_button 'Check Point Information'

        expect(page.current_path).to eql('/walkers/checkpoint_info')
    end

end
