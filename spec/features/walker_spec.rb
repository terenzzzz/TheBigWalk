require 'rails_helper'

describe 'walker' do
    let(:tag1) { FactoryBot.create(:tag) }
    let(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}

    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }
    let!(:checkpoint1) { FactoryBot.create(:checkpoint, event: event) }
    let!(:checkpoint2) { FactoryBot.create(:checkpoint, event: event, name:'test') }
    let!(:checkpoint3) { FactoryBot.create(:checkpoint, event: event, name:'test1') }

    before do
        login_as user1
        
        OptedInLeaderboard.create(opted_in:true,user_id:user1)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint1, route: route, position_in_route: 1)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint2, route: route, position_in_route: 2)
        RoutesAndCheckpointsLinker.create(distance_from_start: 3, advised_time: 30, checkpoint: checkpoint3, route: route, position_in_route: 3)
    end

    specify 'I can Check the Checkpoint Info', js:true do
        visit '/'

        click_on event.name
        click_on route.name

        click_on 'Sign Up For Event'

        click_on 'Check Point Information'

        expect(page.current_path).to eql('/walkers/checkpoint_info')
    end

    specify 'I can Check the Leaderboard' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Leaderboard'
        expect(page.current_path).to eql('/pages/leaderboard')
    end


    # Request Help
    specify 'I can click on request help'do
        visit '/'

        click_on event.name
        click_on route.name

        click_on 'Sign Up For Event'

        click_on 'Request Help'

        expect(page.current_path).to eql('/walkers/help')
    end

    specify 'I can Request Call From Staff' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'Request Call From Staff'
        expect(page).to have_content 'Call request successful.'
    end

    #Not Complete
    specify 'I can Request Call Head Marshal', js:true do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'Request Call From Staff'
        expect(page).to have_content 'Call request successful.'
    end

    specify 'I can Report issue of the site' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'Report Issue With The Website'
        expect(page.current_path).to eql('/reports/new')
    end
    
    specify 'I can Submit Report ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'Report Issue With The Website'

        fill_in "Subject", with: 'Terenzzzz'
        fill_in "Description", with: 'Terenzzzz'
        click_on 'Submit'
        expect(page).to have_content 'Report was created.'
    end

    specify 'I can Go To Drop Out ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'I\'d Like To Drop Out'
        expect(page.current_path).to eql('/walkers/drop_out')
    end

    specify 'I can Drop Out And Need Pick Up ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'I\'d Like To Drop Out'

        click_on 'I Need Picking Up'
        expect(page).to have_content 'Pick up request successful.'
    end

    specify 'I can Drop Out And Need Pick Up ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'Request Help'
        click_on 'I\'d Like To Drop Out'

        click_on 'Making My Own Way Home'
        expect(page.current_path).to eql('/users/sign_in')
    end

    #Update Location
    specify 'I can Update My Location ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'UpdateLocation'
        expect(page).to have_content 'Your location has been updated.'
    end

    #Update Location
    specify 'I can Check In Fail ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'UpdateLocation'
        click_on 'Check Me In'
        expect(page.current_path).to eql('/walkers/check_in_fail')
    end

    specify 'I can View My Time ' do
        visit '/'
        click_on event.name
        click_on route.name
        click_on 'Sign Up For Event'
        click_on 'View My Times'
        expect(page.current_path).to eql('/pages/single_user_leaderboard')
    end


end
