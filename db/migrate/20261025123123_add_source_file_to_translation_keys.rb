class AddSourceFileToTranslationKeys < ActiveRecord::Migration[8.1]
  def change
    add_reference :translation_keys, :source_file, null: true, foreign_key: true
  end
end
