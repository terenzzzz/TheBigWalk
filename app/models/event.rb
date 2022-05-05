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
    
    # has_many :checkpoints, class_name: "Checkpoints", foreign_key: "events_id", dependent: :destroy
    # has_many :routes, class_name: "Routes", foreign_key: "events_id", dependent: :destroy
    # has_one :branding, class_name: "Branding", foreign_key: "events_id", dependent: :destroy
    # has_many :calls, class_name: "Calls", foreign_key: "event_id", dependent: :destroy
    # has_many :participants, class_name: "Participants", foreign_key: "event_id"

    has_many :checkpoints, dependent: :destroy
    has_many :routes, dependent: :destroy
    has_one :branding, dependent: :destroy
    has_many :calls, dependent: :destroy
    has_many :participants


end
