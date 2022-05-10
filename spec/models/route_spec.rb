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
#  event_id      :bigint           not null
#
# Indexes
#
#  index_routes_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

require 'rails_helper'

RSpec.describe Route, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
