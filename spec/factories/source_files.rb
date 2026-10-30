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
FactoryBot.define do
  factory :source_file do
    association :batch
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.json'), 'application/json') }
    status { :pending }
  end
end
