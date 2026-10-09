require 'rails_helper'

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
#  game_id     :integer
#
RSpec.describe TranslationKey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
