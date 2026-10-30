# == Schema Information
#
# Table name: batches
# Database name: primary
#
#  id            :bigint           not null, primary key
#  codename      :string
#  source_locale :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :integer
#
FactoryBot.define do
  factory :batch do
    association :game
    state { "pending" }
    source_locale { "en" }
  end
end
