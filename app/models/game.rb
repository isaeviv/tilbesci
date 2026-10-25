# == Schema Information
#
# Table name: games
# Database name: primary
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  has_many :batches, dependent: :destroy
  has_many :translation_keys, dependent: :destroy
  has_many :translations, through: :translation_keys

  validates :name, presence: true, uniqueness: true
end
