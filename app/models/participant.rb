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
#  check_point_id :integer
#  checkpoints_id :bigint           not null
#  participant_id :integer
#  route_id       :integer
#  routes_id      :bigint           not null
#  user_id        :integer
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
class Participant < ApplicationRecord
end
