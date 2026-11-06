# == Schema Information
#
# Table name: source_files
# Database name: primary
#
#  id         :bigint           not null, primary key
#  file       :string
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batch_id   :bigint           not null
#
# Indexes
#
#  index_source_files_on_batch_id  (batch_id)
#
# Foreign Keys
#
#  fk_rails_...  (batch_id => batches.id)
#
class SourceFile < ApplicationRecord
  extend Enumerize

  belongs_to :batch
  has_many :translation_keys, dependent: :nullify

  enumerize :status, in: { pending: 0, processing: 1, processed: 2, failed: 3, translating: 4, translated: 5}, default: :pending, scope: true

  mount_uploader :file, FileUploader

  validates :file, presence: true

  def mark_as_translating!
    update!(status: :translating)
  end

  def mark_as_translated!
    update!(status: :translated)
  end
end
