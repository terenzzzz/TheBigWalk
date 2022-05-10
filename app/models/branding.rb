# == Schema Information
#
# Table name: brandings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_brandings_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Branding < ApplicationRecord
    has_one_attached :header
    has_one_attached :logo
    belongs_to :event, class_name: "Event", foreign_key: "event_id"
end
