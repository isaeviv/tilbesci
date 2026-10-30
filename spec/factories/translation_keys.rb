# == Schema Information
#
# Table name: translation_keys
# Database name: primary
#
#  id             :bigint           not null, primary key
#  description    :text
#  name           :string
#  state          :string
#  translated     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  batch_id       :integer
#  game_id        :integer
#  source_file_id :bigint
#
# Indexes
#
#  index_translation_keys_on_source_file_id  (source_file_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_file_id => source_files.id)
#
FactoryBot.define do
  factory :translation_key do
    sequence(:name) { |n| "translation.key_#{n}" }
    description { "Test translation key" }
    state { :pending }
    association :game
  end
end
