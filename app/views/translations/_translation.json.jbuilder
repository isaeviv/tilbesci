json.extract! translation, :id, :translation_key_id, :locale, :value, :state, :source, :created_at, :updated_at
json.url translation_url(translation, format: :json)
