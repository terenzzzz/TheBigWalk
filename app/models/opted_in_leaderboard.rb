# == Schema Information
#
# Table name: opted_in_leaderboards
#
#  id         :bigint           not null, primary key
#  opted_in   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_opted_in_leaderboards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class OptedInLeaderboard < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    #belongs_to :user
end
