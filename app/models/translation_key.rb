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
class TranslationKey < ApplicationRecord
  extend Enumerize

  belongs_to :game
  belongs_to :batch, optional: true
  belongs_to :source_file, optional: true
  has_many :translations, dependent: :destroy

  enumerize :state, in: [:pending, :translated, :failure], default: :pending

  validates :name, presence: true, uniqueness: { scope: :game_id }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "state"]
  end

   def self.ransackable_associations(auth_object = nil)
    ["batch", "game", "source_file", "translations"]
  end
end
