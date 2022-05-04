# == Schema Information
#
# Table name: checkpoints
#
#  id         :bigint           not null, primary key
#  name       :string
#  os_grid    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  events_id  :bigint           not null
#
# Indexes
#
#  index_checkpoints_on_events_id  (events_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_id => events.id)
#
class Checkpoint < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :os_grid
    validates_uniqueness_of :name, scope: :events_id

    belongs_to :event, class_name: "Event", foreign_key: "events_id"
    has_many :routes_and_checkpoints_linkers, class_name: "RoutesAndCheckpointsLinkers", foreign_key: "checkpoint_id"
    has_many :checkpoint_times, class_name: "CheckpointTimes", foreign_key: "checkpoint_id"
    has_many :participants, class_name: "Participants", foreign_key: "checkpoints_id"
    # has_many :marshalls, class_name: "Marshalls", foreign_key: "checkpoints_id"
end
