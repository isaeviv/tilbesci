# == Schema Information
#
# Table name: games
# Database name: primary
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :game do
    name { Faker::Games.name }
  end
end
