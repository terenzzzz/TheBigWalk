require 'rails_helper'

describe 'admin' do
    let!(:event) { FactoryBot.create(:event, :public_event) }
    let!(:route) { FactoryBot.create(:route, event: event) }

    let!(:checkpoint1) { Checkpoint.create(name: "test1", os_grid: 'SK331896', event: event)}
    let!(:linker1) { RoutesAndCheckpointsLinker.create(distance_from_start: '10',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint1,position_in_route: '1')}
    
    let!(:checkpoint2) { Checkpoint.create(name: "test2", os_grid: 'SK331896', event: event)}
    let!(:linker2) { RoutesAndCheckpointsLinker.create(distance_from_start: '50',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint2,position_in_route: '2')}
    
    let!(:checkpoint3) { Checkpoint.create(name: "test3", os_grid: 'SK331896', event: event)}
    let!(:linker3) { RoutesAndCheckpointsLinker.create(distance_from_start: '100',checkpoint_description: "Head to the main road (A6187)",advised_time: 20,route: route,checkpoint: checkpoint3,position_in_route: '3')}
    

    let!(:tag1) { FactoryBot.create(:tag) }
    let!(:user1) {  FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1)}
    let!(:opted_in) { OptedInLeaderboard.where(user:user1).first_or_create(opted_in: true) }

    let(:tag2) { FactoryBot.create(:tag, :admin) }
    let(:user2) { FactoryBot.create(:user, name:'tests', email: 'testadmin@test.com', mobile:'00000000000', tag: tag2) }

    let(:tag3) { FactoryBot.create(:tag, :marshal) }
    let(:user3) { FactoryBot.create(:user, name:'testss', email: 'testmarshal@test.com', mobile:'00000000000', tag: tag3) }
    let(:marshal1) { Marshall.create(marshal_id: '2091', checkpoints_id: checkpoint1.id, user_id: user3.id) }


    context 'As an admin' do

        specify 'I can view participants on an event' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Participants'
            expect(page).to have_content Participant.where(user_id: user1).first.participant_id
            expect(page).to have_content user1.name
            expect(page).to have_content checkpoint1.name
            expect(page).to have_content 'On Pace'
        end

        specify 'I can view the leaderboard' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Event Leaderboard'
            click_on 'View'
            expect(page).to have_content Participant.where(user_id: user1).first.rank
            expect(page).to have_content user1.name
            expect(page).to have_content checkpoint1.name
        end

        specify 'I can view the marshals' do
            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Marshals'
            #expect(Tag.where(name:'Marshal').first.name).to eq("Marshal")
            expect(page).to have_content user3.name
            expect(page).to have_content checkpoint1.name
            expect(page).to have_content '----'
        end

        specify 'I can view call requests' do
            #walker
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'Request Call From Staff'
            visit '/users/sign_out'

            #admin
            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Phone Call Requests'
            expect(page).to have_content Participant.where(user_id: user1).first.participant_id
            expect(page).to have_content user1.name
            expect(page).to have_content user1.mobile
        end

        specify 'I can delete phone call requests' do 
            #walker
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'Request Call From Staff'
            visit '/users/sign_out'

            #admin
            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Phone Call Requests'
            click_on 'Delete Call Request'
            expect(page).not_to have_content Participant.where(user_id: user1).first.participant_id
            expect(page).not_to have_content user1.name
            expect(page).not_to have_content user1.mobile
        end


        specify 'I can view reports on issues with the site' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'Report Issue With The Website'
            fill_in "Subject", with: 'Terenzzzz'
            fill_in "Description", with: 'Terenzzzz2'
            click_on 'Submit'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on 'View Reported Issues With Site'
            expect(page).to have_content user1.name
            expect(page).to have_content 'Terenzzzz'
            expect(page).to have_content 'Terenzzzz2'
        end

        specify 'I can delete reports on issues with the site' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'Report Issue With The Website'
            fill_in "Subject", with: 'Terenzzzz'
            fill_in "Description", with: 'Terenzzzz2'
            click_on 'Submit'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on 'View Reported Issues With Site'
            click_on 'Remove Issue Report'
            expect(page).not_to have_content user1.name
            expect(page).not_to have_content 'Terenzzzz'
            expect(page).not_to have_content 'Terenzzzz2'
        end

        specify 'I can view pickup requests' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'I\'d Like To Drop Out'
            click_on 'I Need Picking Up'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Pick-Up Requests'
            expect(page).to have_content Participant.where(user_id: user1).first.participant_id
            expect(page).to have_content user1.name
        end

        specify 'I can delete pickup requests' do
            login_as user1
            visit '/'
            click_on event.name
            click_on route.name
            click_on 'Sign Up For Event'
            click_on 'Request Help'
            click_on 'I\'d Like To Drop Out'
            click_on 'I Need Picking Up'
            visit '/users/sign_out'

            login_as user2
            visit '/'
            click_on event.name
            click_on 'View Pick-Up Requests'
            click_on 'Remove Pickup Request'
            expect(page).not_to have_content Participant.where(user_id: user1).first.participant_id
            expect(page).not_to have_content user1.name
        end
    end
end
