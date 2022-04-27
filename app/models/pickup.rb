# == Schema Information
#
# Table name: pickups
#
#  id         :bigint           not null, primary key
#  os_grid    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pickups_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Pickup < ApplicationRecord
end
