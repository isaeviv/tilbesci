class CreateTranslationKeys < ActiveRecord::Migration[8.1]
  def change
    create_table :translation_keys do |t|
      t.string :name
      t.text :description
      t.string :state
      t.integer :game_id
      t.boolean :translated

      t.timestamps
    end
  end
end
