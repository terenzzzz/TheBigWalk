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
#  checkpoints_id         :bigint           not null
class Participant < ApplicationRecord
end
