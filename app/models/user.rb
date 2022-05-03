# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  description            :string
#  donate_link            :string
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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  belongs_to :tag, optional: true

  has_many :calls, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_one :opted_in_leaderboard, dependent: :destroy



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name
  validates_presence_of :mobile


end
