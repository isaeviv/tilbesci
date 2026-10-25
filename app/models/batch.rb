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
class Batch < ApplicationRecord
  extend Enumerize

  belongs_to :game
  has_many :translation_keys, dependent: :destroy
  has_many :translations, through: :translation_keys

  enumerize :state, in: [:pending, :in_progress, :translated], default: :pending
  enumerize :source_locale, in: [:en, :ru, :kjh, :eo, :isv]

  mount_uploader :file, FileUploader

  before_create :set_codename 
  
  private
  
  def set_codename
    self.codename = Faker::Games::HalfLife.unique.enemy
  end
end
