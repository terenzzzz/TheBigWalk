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
    association(:event)

    name { '10KM' }
    start_date { 10.days.from_now }    
    start_time { DateTime.new(2022, 5, 1, 12, 0) }
    end_date_time { 11.days.from_now } 

    course_length { 10 }

  end
end
