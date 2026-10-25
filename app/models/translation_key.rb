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
class TranslationKey < ApplicationRecord
  extend Enumerize

  belongs_to :game
  belongs_to :batch, optional: true
  has_many :translations, dependent: :destroy

  enumerize :state, in: [:pending, :translated], default: :pending

  validates :name, presence: true, uniqueness: { scope: :game_id }
end
