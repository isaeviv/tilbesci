# == Schema Information
#
# Table name: translation_keys
# Database name: primary
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  state       :string
#  translated  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  batch_id    :integer
#  game_id     :integer
#
FactoryBot.define do
  factory :translation_key do
    sequence(:name) { |n| "translation.key_#{n}" }
    description { "Test translation key" }
    state { :pending }
    association :game
  end
end
