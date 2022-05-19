# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name { "Walker" }

    trait :admin do
      name { "Admin" }
    end

    trait :marshal do
      name { "Marshal" }
    end
  end
end
