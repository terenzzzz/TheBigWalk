# == Schema Information
#
# Table name: routes_and_checkpoints_linkers
#
#  id                     :bigint           not null, primary key
#  advised_time           :integer
#  checkpoint_description :string
#  distance_from_start    :float
#  position_in_route      :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  checkpoint_id          :bigint           not null
#  route_id               :bigint           not null
#
# Indexes
#
#  index_routes_and_checkpoints_linkers_on_checkpoint_id  (checkpoint_id)
#  index_routes_and_checkpoints_linkers_on_route_id       (route_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoint_id => checkpoints.id)
#  fk_rails_...  (route_id => routes.id)
#
FactoryBot.define do
    factory :routes_and_checkpoints_linker do
      distance_from_start { 1.5 }
      position_in_route { 1 }
      advised_time { 10 }
      checkpoint_description { "A Checkpoint" }
      checkpoint_id { 1 }
      route_id { 1 }
    end
  end
