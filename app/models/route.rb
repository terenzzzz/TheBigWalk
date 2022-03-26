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
class Route < ApplicationRecord
end
