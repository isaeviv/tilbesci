# == Schema Information
#
# Table name: translations
# Database name: primary
#
#  id                 :bigint           not null, primary key
#  locale             :string
#  source             :string
#  state              :string
#  value              :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  translation_key_id :integer
#
# Indexes
#
#  index_translations_on_locale                         (locale)
#  index_translations_on_locale_and_state               (locale,state)
#  index_translations_on_state                          (state)
#  index_translations_on_translation_key_id_and_locale  (translation_key_id,locale) UNIQUE
#
class Translation < ApplicationRecord
  extend Enumerize

  enumerize :locale, in: [:en, :ru, :kjh, :eo, :isv]

  belongs_to :translation_key

  validates :locale, presence: true
  validates :value, presence: true
end
