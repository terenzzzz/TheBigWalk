# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  admin_id               :integer
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
    factory :admin do
        admin_id {1}
        user_id {1}
    end
end