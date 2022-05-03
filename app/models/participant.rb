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
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (routes_id => routes.id)
#
class Participant < ApplicationRecord
    belongs_to :user
    has_many :checkpoint_times, dependent: :destroy
end
