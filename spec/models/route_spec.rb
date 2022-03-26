# == Schema Information
#
# Table name: routes
#
#  id         :bigint           not null, primary key
#  length     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  route_id   :integer
#
require 'rails_helper'

RSpec.describe Route, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
