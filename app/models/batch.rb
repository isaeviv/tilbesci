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
class Batch < ApplicationRecord
  extend Enumerize

  belongs_to :game
  has_many :source_files, dependent: :destroy
  has_many :translation_keys, dependent: :destroy
  has_many :translations, through: :translation_keys

  enumerize :state, in: [:pending, :in_progress, :translated], default: :pending
  enumerize :source_locale, in: [:en, :ru, :kjh, :eo, :isv]

  accepts_nested_attributes_for :source_files, allow_destroy: true, reject_if: :all_blank

  before_create :set_codename

  def mark_as_in_progress!
    update!(state: :in_progress)
  end

  def mark_as_translated!
    update!(state: :translated)
  end

  def all_source_files_translated?
    source_files.all? { |sf| sf.status.translated? }
  end

  private

  def set_codename
    self.codename = Faker::Games::HalfLife.unique.enemy
  end
end
