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
FactoryBot.define do
  factory :checkpoint do
    name { "Hope Cross" }
    os_grid { "SK123456" }
    event_id { 1 }
  end
end
