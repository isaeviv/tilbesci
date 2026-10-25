# == Schema Information
#
# Table name: batches
# Database name: primary
#
#  id            :bigint           not null, primary key
#  codename      :string
#  file          :string
#  source_locale :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :integer
#
FactoryBot.define do
  factory :batch do
    association :game
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'parsing', 'example.json'), 'text/json') }
    state { "pending" }
    source_locale { "en" }
  end
end
