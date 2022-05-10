# == Schema Information
#
# Table name: brandings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  events_id  :bigint           not null
#
# Indexes
#
#  index_brandings_on_events_id  (events_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_id => events.id)
#
FactoryBot.define do
  factory :branding do
    events_id { 1 }
  end
end
