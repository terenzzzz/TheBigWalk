# == Schema Information
#
# Table name: marshal_shifts
#
#  id           :bigint           not null, primary key
#  current_time :datetime
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  marshalls_id :bigint
#
# Indexes
#
#  index_marshal_shifts_on_marshalls_id  (marshalls_id)
#
# Foreign Keys
#
#  fk_rails_...  (marshalls_id => marshalls.id)
#
class MarshalShift < ApplicationRecord
end
