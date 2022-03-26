# == Schema Information
#
# Table name: checkpoints
#
#  id          :bigint           not null, primary key
#  advisedTime :integer
#  description :string
#  distance    :float
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  events_id   :bigint           not null
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
end
