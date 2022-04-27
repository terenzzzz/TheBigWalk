# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  description :string
#  subject     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
FactoryBot.define do
  factory :report do
    subject { "MyString" }
    description { "MyString" }
    user_id { 1 }
  end
end
