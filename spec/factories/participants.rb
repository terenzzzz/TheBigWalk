# == Schema Information
#
# Table name: participants
#
#  id                     :bigint           not null, primary key
#  participant_id         :integer
#  pace                   :string           
#  arrival_time           :datetime
#  rank                   :integer
#  status                 :string
#  route_id               :integer
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  check_point_id         :integer
#
FactoryBot.define do
    factory :participant do
        participant_id { 1 }
        pace { "MyString"}
        rank { 1 }
        status { "MyString" }
        route_id { 1 }
        user_id { 1 }
        check_point_id { 1 }
    end
end 