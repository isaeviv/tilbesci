class CreateTranslations < ActiveRecord::Migration[8.1]
  def change
    create_table :translations do |t|
      t.integer :translation_key_id
      t.string :locale
      t.text :value
      t.string :state
      t.string :source

      t.timestamps
    end
  end
end
