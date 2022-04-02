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
FactoryBot.define do
  factory :checkpoint do
    name { "Hope Cross" }
    distance { 1.5 }
    location { "SK12345" }
    advisedTime { 1 }
    description { "A Checkpoint" }
  end
end
