# == Schema Information
#
# Table name: routes
#
#  id             :bigint           not null, primary key
#  length         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  checkpoints_id :bigint           not null
#  route_id       :integer
#
# Indexes
#
#  index_routes_on_checkpoints_id  (checkpoints_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#
# Indexes
#
#  index_routes_on_checkpoints_id  (checkpoints_id)
#
# Foreign Keys
#
#  fk_rails_...  (checkpoints_id => checkpoints.id)
#

require 'rails_helper'

RSpec.describe Route, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
