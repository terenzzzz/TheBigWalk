# == Schema Information
#
# Table name: marshals
#
#  id             :bigint           not null, primary key
#  marshal_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
    factory :marshall do
        marshal_id { 1 }
        users_id { 1 }
        checkpoints_id { 2 }
    end
end