# == Schema Information
#
# Table name: marshalls
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkPoint_id  :integer
#  checkpoints_id :bigint           not null
#  marshal_id     :integer
#  user_id        :integer
#  users_id       :bigint           not null
#
# Indexes
#
#  index_marshalls_on_checkpoints_id  (checkpoints_id)
#  index_marshalls_on_users_id        (users_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#  fk_rails_...  (users_id => users.id)
#
class Marshall < ApplicationRecord
end
