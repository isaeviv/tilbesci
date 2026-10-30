require 'rails_helper'

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
RSpec.describe SourceFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
