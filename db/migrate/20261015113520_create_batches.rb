class CreateBatches < ActiveRecord::Migration[8.1]
  def change
    create_table :batches do |t|
      t.integer :game_id
      t.string :codename
      t.string :file
      t.string :state

      t.timestamps
    end
  end
end
