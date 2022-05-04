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
class RoutesAndCheckpointsLinker < ApplicationRecord
    validates_presence_of :distance_from_start
    validates_presence_of :advised_time
    validates_uniqueness_of :distance_from_start, scope: :route_id
    validates :distance_from_start, :numericality => { :greater_than_or_equal_to => 1 }
    validates :advised_time, :numericality => { :greater_than_or_equal_to => 1 }


    belongs_to :checkpoint, class_name: "Checkpoint", foreign_key: "checkpoint_id"
    belongs_to :route, class_name: "Route", foreign_key: "route_id"
end
