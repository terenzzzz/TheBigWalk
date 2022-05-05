# == Schema Information
#
# Table name: checkpoint_times
#
#  id             :bigint           not null, primary key
#  times          :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoint_id  :bigint           not null
#  participant_id :bigint           not null
#
# Indexes
#
#  index_checkpoint_times_on_checkpoint_id   (checkpoint_id)
#  index_checkpoint_times_on_participant_id  (participant_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoint_id => checkpoints.id)
#  fk_rails_...  (participant_id => participants.id)
#
class CheckpointTime < ApplicationRecord
    belongs_to :participant, class_name: "Participant", foreign_key: "participant_id"
    belongs_to :checkpoint, class_name: "Checkpoint", foreign_key: "checkpoint_id"
    #belongs_to :participant
    #belongs_to :checkpoint
    
end
