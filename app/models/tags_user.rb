# == Schema Information
#
# Table name: tags_users
#
#  tag_id  :bigint           not null
#  user_id :bigint           not null
#
# Indexes
#
#  index_tags_users_on_tag_id_and_user_id  (tag_id,user_id)
#  index_tags_users_on_user_id_and_tag_id  (user_id,tag_id)
#
class TagsUser < ApplicationRecord
end
