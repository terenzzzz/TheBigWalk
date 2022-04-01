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
#
require 'rails_helper'

RSpec.describe Participant, type: model do
    pending "add some examples to (or delete) #{__FILE__}"
end