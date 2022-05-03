# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  made_public  :boolean
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Event < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :name
end
