class AddIndex < ActiveRecord::Migration[8.1]
  def change
    add_index :translations, [:translation_key_id, :locale], unique: true
    add_index :translations, :locale
    add_index :translations, :state
    add_index :translations, [:locale, :state]
  end
end
