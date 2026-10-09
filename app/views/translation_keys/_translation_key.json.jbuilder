json.extract! translation_key, :id, :name, :description, :state, :game_id, :translated, :created_at, :updated_at
json.url translation_key_url(translation_key, format: :json)
