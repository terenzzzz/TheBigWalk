# == Schema Information
#
# Table name: routes
#
#  id         :bigint           not null, primary key
#  length     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  route_id   :integer
#
FactoryBot.define do
  factory :route do
    route_id { 1 }
    length { "MyString" }
  end
end
