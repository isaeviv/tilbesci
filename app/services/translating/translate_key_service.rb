module Translating
  class TranslateKeyService
    attr_reader :translation_key, :source_locale, :target_locale

    def initialize(translation_key, source_locale, target_locale)
      @translation_key = translation_key
      @source_locale = source_locale
      @target_locale = target_locale
    end

    def call
      source_translation = translation_key.translations.with_locale(source_locale).first
      return if source_translation.blank? || source_translation.value.blank?
      return if garbage_value?(source_translation.value)

      begin
        result = YandexService.new(source_translation.value, target_locale).call
      rescue YandexService::YandexTranslatingError => e
        Rails.logger.error("### TranslateKeyService error for key #{translation_key.id}: #{e.message}")
        return
      end

      translated_text = result.dig("translations", 0, "text")
      if translated_text.blank?
        Rails.logger.error("### Yandex Translator returns empty text for key #{translation_key.id}, result: #{result}")
        return
      end

      target_translation = translation_key.translations.with_locale(target_locale).first_or_initialize
      if target_translation.value != translated_text
        target_translation.value = translated_text
        target_translation.save!
      end
    end

    private

    def garbage_value?(value)
      # Только цифры (с пробелами/знаками)
      return true if value.match?(/\A[\d\s\.,;:!?\-+*=\/()]*\z/)
      # Только спецсимволы (без букв)
      return true if value.match?(/\A[\s\p{P}\p{S}]*\z/)
      false
    end
  end
end
