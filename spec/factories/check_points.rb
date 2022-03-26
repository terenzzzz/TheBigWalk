# == Schema Information
#
# Table name: check_points
#
#  id             :bigint           not null, primary key
#  advice_time    :string
#  code           :string
#  grid_reference :string
#  location       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  check_point_id :integer
#
FactoryBot.define do
  factory :check_point do
    locheck_point_id { 1 }
    location { "MyString" }
    advice_time { "MyString" }
    code { "MyString" }
    grid_reference { "MyString" }
  end
end
