# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  made_public :boolean
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
    factory :event do
        name { "The Big Walk" }
    end
end
