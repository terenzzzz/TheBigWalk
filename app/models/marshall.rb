# == Schema Information
#
# Table name: marshalls
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoints_id :bigint
#  marshal_id     :integer
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
    belongs_to :user
end
