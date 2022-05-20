# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  description :string
#  subject     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
require 'rails_helper'

RSpec.describe Report, type: :module do
  pending "add some examples to (or delete) #{__FILE__}"
end
