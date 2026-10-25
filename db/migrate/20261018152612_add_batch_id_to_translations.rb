class AddBatchIdToTranslations < ActiveRecord::Migration[8.1]
  def change
    add_column :translations, :batch_id, :integer
  end
end
