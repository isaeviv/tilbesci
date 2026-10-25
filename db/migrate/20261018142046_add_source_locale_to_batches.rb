class AddSourceLocaleToBatches < ActiveRecord::Migration[8.1]
  def change
    add_column :batches, :source_locale, :string
  end
end
