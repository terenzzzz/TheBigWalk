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
#
FactoryBot.define do
  factory :check_point do
    location { "MyString" }
    advice_time { "MyString" }
    code { "MyString" }
    grid_reference { "MyString" }
  end
end
