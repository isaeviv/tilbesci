module Translating
  class TranslateKeyJob < ApplicationJob
    queue_as :default

    def perform(translation_key_id, source_locale, target_locale)
      translation_key = TranslationKey.find(translation_key_id)
      TranslateKeyService.new(translation_key, source_locale, target_locale).call
    end
  end
end
