require 'rails_helper'

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
RSpec.describe TranslationKey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
