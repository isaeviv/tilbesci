class AddBatchIdToTranslationKeys < ActiveRecord::Migration[8.1]
  def change
    add_column :translation_keys, :batch_id, :integer
  end
end
