# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  description            :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  mobile                 :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  membership_id          :string
#  tag_id                 :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_tag_id                (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#
FactoryBot.define do
  factory :user do
    description { "MyString" }
    mobile { "MyString" }
    name { "MyString" }
    reset_password_token { "MyString" }
    membership_id { "MyString" }
  end
end
