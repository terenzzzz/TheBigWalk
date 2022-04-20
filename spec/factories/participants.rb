# == Schema Information
#
# Table name: participants
#
#  id             :bigint           not null, primary key
#  arrival_time   :datetime
#  pace           :string
#  rank           :integer
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoints_id :bigint           not null
#  participant_id :integer
#  routes_id      :bigint           not null
#  users_id       :bigint           not null
#
# Indexes
#
#  index_participants_on_checkpoints_id  (checkpoints_id)
#  index_participants_on_routes_id       (routes_id)
#  index_participants_on_users_id        (users_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#  fk_rails_...  (routes_id => routes.id)
#  fk_rails_...  (users_id => users.id)
#
FactoryBot.define do
    factory :participant do
        participant_id { 1 }
        pace { "MyString"}
        rank { 1 }
        status { "MyString" }
        checkpoints_id { 1 }
        users_id { 1 }
        routes_id { 1 }
    end
end 
