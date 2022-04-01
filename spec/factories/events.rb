# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  date       :date
#  length     :integer
#  name       :string
#  time       :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
    factory :event do
        name { "MyString" }
        length {1}
        eventID {1}
    end
end
