# == Schema Information
#
# Table name: marshals
#
#  id             :bigint           not null, primary key
#  marshal_id     :integer
#  checkPoint_id  :integer
#  user_id        :integer
#  check_point_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
class Marshall < ApplicationRecord
end
