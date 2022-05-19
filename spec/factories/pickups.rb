# == Schema Information
#
# Table name: pickups
#
#  id         :bigint           not null, primary key
#  os_grid    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pickups_on_event_id  (event_id)
#  index_pickups_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :pickup do
    os_grid { "MyString" }
  end
end
