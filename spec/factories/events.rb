# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  made_public  :boolean
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
    factory :event do
        name { "The Big Walk" }
        phone_number { "07757291463" }
        
        trait :public_event do
            made_public { true }
        end
    end
end
