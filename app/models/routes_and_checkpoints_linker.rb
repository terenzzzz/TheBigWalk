# == Schema Information
#
# Table name: routes_and_checkpoints_linkers
#
#  id                     :bigint           not null, primary key
#  advised_time           :integer
#  checkpoint_description :string
#  distance_from_start    :float
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
class RoutesAndCheckpointsLinker < ApplicationRecord
    validates_presence_of :distance_from_start
end
