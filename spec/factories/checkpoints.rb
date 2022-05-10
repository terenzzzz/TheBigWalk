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
FactoryBot.define do
  factory :checkpoint do
    name { "Hope Cross" }
    os_grid { "SK123456" }
    # advisedTime { 1 }
    # description { "A Checkpoint" }
    events_id { 1 }
  end
end
