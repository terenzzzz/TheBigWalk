require 'rails_helper'

describe 'checkpoints' do
    let(:tag1) { FactoryBot.create(:tag, :admin) }
    let(:user1) { FactoryBot.create(:user, name:'test', email: 'test@test.com', mobile:'00000000000', tag: tag1) }

    context 'As an admin' do
        before do
            login_as user1
        end
        specify "I can create a checkpoint for a route" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            
            #find(:css, "#selected_routes[value='#{(Route.where(name: '50km')).order("created_at").last.id}']").set(true)
            #find(:css, "#selected_routes[#{(Route.where(name: '50km')).order("created_at").last.id}]").set(true)
            check "selected_routes[]"
            click_on "Save"

            fill_in 'Distance From The Start (Km):', with: '1.5'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '10'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
        end

        specify "I can create a checkpoint for multiple routes" do
            skip
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '30km'
            fill_in 'Course Length (Km):', with: '30'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            
            #cant pick multiple routes
            check 'selected_routes[]'
            check 'selected_routes[]'
            click_on "Save"
            fill_in 'Distance From The Start (Km):', with: '2'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '20'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            fill_in 'Distance From The Start (Km):', with: '1.5'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '10'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
        end

        specify "I can create a checkpoint for no routes" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
            
        end

        specify "I cant create a checkpoint where it has a duplicate name" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I cant create a checkpoint where it has an incorrect os grid" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK12345'
            click_on "Save"
            expect(page).to have_content 'Please review the problems below:'
        end

        specify "I can create a checkpoint for a route later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Checkpoints"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            
            #find(:css, "#selected_routes[value='#{(Route.where(name: '50km')).order("created_at").last.id}']").set(true)
            #find(:css, "#selected_routes[#{(Route.where(name: '50km')).order("created_at").last.id}]").set(true)
            check "selected_routes[]"
            click_on "Save"

            fill_in 'Distance From The Start (Km):', with: '1.5'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '10'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
        end

        specify "I can create a checkpoint for multiple routes  later on" do
            skip
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Checkpoints"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            
            #find(:css, "#selected_routes[value='#{(Route.where(name: '50km')).order("created_at").last.id}']").set(true)
            #find(:css, "#selected_routes[#{(Route.where(name: '50km')).order("created_at").last.id}]").set(true)
            check "selected_routes[]"
            check "selected_routes[]"
            click_on "Save"

            fill_in 'Distance From The Start (Km):', with: '2'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '20'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            fill_in 'Distance From The Start (Km):', with: '1.5'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '10'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
        end

        specify "I can create a checkpoint for no routes later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Checkpoints"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 1')
        end

        specify "I can edit a checkpoint after creating it" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            click_on "Edit"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 2'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 2')
        end

        specify "I can remove a route when editing a checkpoint after creating it" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            check "selected_routes[]"
            click_on "Save"
            fill_in 'Distance From The Start (Km):', with: '1.5'
            fill_in 'Advised Time To Next Checkpoint (Mins):', with: '10'
            fill_in 'Description Of Route To The Next Checkpoint:', with: 'A Checkpoint'
            click_on "Save"

            click_on "Edit"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 2'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            expect{click_on 'Save'}.to change(RoutesAndCheckpointsLinker, :count)
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 2')
        end

        specify "I can delete a checkpoint after creating it" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            click_on "Next"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            click_on "Edit"
            expect{click_on 'Delete'}.to change(Checkpoint, :count)
        end

        specify "I can edit a checkpoint later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Checkpoints"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            click_on "Edit"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 2'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            expect(page.current_path).to eql('/checkpoints')
            expect(page).to have_content('Checkpoint 2')
        end

        specify "I can delete a checkpoint later on" do
            visit "/"
            click_link 'Create New Event'
            fill_in 'Event Name:', with: 'The Big Walk'
            fill_in 'Head Marshal Phone Number:', with: '07757291463'
            click_button 'Create'
            click_link 'Create New Route'
            fill_in 'Route Name:', with: '50km'
            fill_in 'Course Length (Km):', with: '50'
            click_button 'Create'
            visit "/"
            click_on "The Big Walk"
            click_on "Event Info"
            click_on "Manage Checkpoints"
            click_on "Create New Checkpoint"
            fill_in 'Checkpoint Name:', with: 'Checkpoint 1'
            fill_in 'OS Grid Reference:', with: 'SK123456'
            click_on "Save"
            click_on "Edit"
            expect{click_on 'Delete'}.to change(Checkpoint, :count)
        end
    end
end