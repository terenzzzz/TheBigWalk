# == Schema Information
#
# Table name: participants
#
#  id             :bigint           not null, primary key
#  arrival_time   :datetime
#  pace           :string
#  rank           :integer
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoints_id :bigint           not null
#  event_id       :bigint           not null
#  participant_id :integer
#  routes_id      :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_participants_on_checkpoints_id  (checkpoints_id)
#  index_participants_on_event_id        (event_id)
#  index_participants_on_routes_id       (routes_id)
#  index_participants_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (routes_id => routes.id)
#  fk_rails_...  (user_id => users.id)
#
class Participant < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    #belongs_to :user
    #has_many :checkpoint_times, class_name: "CheckpointTimes", foreign_key: "participant_id", dependent: :destroy
    has_many :checkpoint_times, dependent: :destroy
    #belongs_to :event
    #belongs_to :route
    #belongs_to :checkpoint
    # has_many :checkpoint_times, dependent: :destroy
    belongs_to :event, class_name: "Event", foreign_key: "event_id"
    belongs_to :route, class_name: "Route", foreign_key: "routes_id"
    belongs_to :checkpoint, class_name: "Checkpoint", foreign_key: "checkpoints_id"
    validates :participant_id, :numericality => { :greater_than_or_equal_to => 0 }

end
