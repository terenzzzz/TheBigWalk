# == Schema Information
#
# Table name: routes
#
#  id             :bigint           not null, primary key
#  length         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoints_id :bigint           not null
#  route_id       :integer
#
# Indexes
#
#  index_routes_on_checkpoints_id  (checkpoints_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#
FactoryBot.define do
  factory :route do
    route_id { 1 }
    length { "MyString" }
    checkpoints_id { 1 }
  end
end
