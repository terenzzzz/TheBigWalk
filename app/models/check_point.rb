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
#  check_point_id :integer
#
class CheckPoint < ApplicationRecord
end
