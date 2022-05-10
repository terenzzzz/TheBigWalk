# == Schema Information
#
# Table name: checkpoints
#
#  id         :bigint           not null, primary key
#  name       :string
#  os_grid    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_checkpoints_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Checkpoint < ApplicationRecord
    validates_presence_of :name
    validates :os_grid, presence: true, format: { with: /[A-Z]{2}\d{6}/ }
    validates_uniqueness_of :name, scope: :event_id

    belongs_to :event, class_name: "Event", foreign_key: "event_id"
    has_many :routes_and_checkpoints_linkers
    has_many :checkpoint_times
    has_many :participants
    has_many :marshalls
end
