# == Schema Information
#
# Table name: checkpoints
#
#  id          :bigint           not null, primary key
#  advisedTime :integer
#  description :string
#  distance    :float
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Checkpoint < ApplicationRecord
end
