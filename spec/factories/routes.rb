# == Schema Information
#
# Table name: routes
#
#  id            :bigint           not null, primary key
#  course_length :integer
#  end_date_time :datetime
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
    course_length { 50 }
    start_time { 2000-01-01 10:00:00.000000000 +0000 }
    start_date { 2022-06-12 }
    end_date_time { 2022-06-12 19:00:00.000000000 +0000 }
  end
end
