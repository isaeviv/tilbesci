class RemoveFileFromBatches < ActiveRecord::Migration[8.1]
  def change
    remove_column :batches, :file, :string
  end
end
