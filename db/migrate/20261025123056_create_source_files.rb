class CreateSourceFiles < ActiveRecord::Migration[8.1]
  def change
    create_table :source_files do |t|
      t.references :batch, null: false, foreign_key: true
      t.string :file
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
