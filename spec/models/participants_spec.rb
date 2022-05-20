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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe Participant, type: :module do
    pending "add some examples to (or delete) #{__FILE__}"
end