# == Schema Information
#
# Table name: brandings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  events_id  :bigint           not null
#
# Indexes
#
#  index_brandings_on_events_id  (events_id)
#
# Foreign Keys
#
#  fk_rails_...  (events_id => events.id)
#
class Branding < ApplicationRecord
    has_one_attached :header
    has_one_attached :logo
    belongs_to :event, class_name: "Event", foreign_key: "events_id"
    #belongs_to :event
end
