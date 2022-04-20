# == Schema Information
#
# Table name: marshals
#
#  id             :bigint           not null, primary key
#  marshal_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Marshal, type :model do
    pending "add some examples to (or delete) #{__FILE__}"
end