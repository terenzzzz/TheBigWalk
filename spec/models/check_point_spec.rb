# == Schema Information
#
# Table name: check_points
#
#  id             :bigint           not null, primary key
#  advice_time    :string
#  code           :string
#  grid_reference :string
#  location       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
