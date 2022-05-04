# == Schema Information
#
# Table name: routes
#
#  id            :bigint           not null, primary key
#  course_length :integer
#  end_date_time :datetime
#  name          :string
#  start_date    :date
#  start_time    :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  events_id     :bigint           not null
#
# Indexes
#
#  index_routes_on_events_id  (events_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_id => events.id)
#
class Route < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :start_date
    validates_presence_of :start_time
    validates_uniqueness_of :name, scope: :events_id
    validates :course_length, :numericality => { :greater_than_or_equal_to => 1 }

    has_many :participants, class_name: "Participants", foreign_key: "routes_id"
    belongs_to :event, class_name: "Event", foreign_key: "events_id"
    has_many :routes_and_checkpoints_linkers, class_name: "RoutesAndCheckpointsLinkers", foreign_key: "route_id"
end
