# == Schema Information
#
# Table name: routes
#
#  id            :bigint           not null, primary key
#  course_length :integer
#  name          :string
#  start_date    :date
#  start_time    :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  events_id     :bigint           not null
#
# Indexes
#
#  index_routes_on_events_id  (events_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_id => events.id)
#
FactoryBot.define do
  factory :route do
    route_id { 1 }
    length { "MyString" }
    checkpoints_id { 1 }
  end
end
