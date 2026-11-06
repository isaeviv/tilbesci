module Translating
  # • Количество вызовов: до 20 запросов в секунду к одному методу API Квоты и лимиты в Yandex AI Studio.
  # • Объем текста: до 1 миллиона символов в час на перевод или определение языка Квоты и лимиты в Yandex AI Studio.
  # • Размер одного запроса: максимальный суммарный объем текста в параметре texts[] составляет 10 000 символов Translate API v2, REST: Translation.Translate | Yandex AI Studio - Документация.
  # • Глоссарий (GlossaryPairs): от 1 до 50 элементов, каждый длиной не более 10 000 символов для исходного и переведенного текста Translate API v2, REST: Translation.Translate | Yandex AI Studio - Документация.

  class YandexService
    API_URI = URI("https://translate.api.cloud.yandex.net/translate/v2/translate")
    YANDEX_API_KEY = Rails.application.credentials.dig(:yandex_api_key)
    YANDEX_FOLDER_ID = Rails.application.credentials.dig(:yandex_folder_id)
    YandexTranslatingError = Class.new(StandardError)

    attr_reader :text, :target_language

    def initialize text, target_language
      @text = text
      @target_language = target_language
    end

    def call
      response = Net::HTTP.start(API_URI.hostname, API_URI.port, use_ssl: API_URI.scheme == 'https') do |http|
        http.request build_request
      end

      body = JSON.parse response.body

      ### в code яндекс шлет код ошибки при наличии таковой
      if body["code"].present?
        raise YandexTranslatingError, "### YandexTranslatingError, response body: #{body}, text: #{text}, target_language: #{target_language} ###"
      end

      body
    end

    private

    def build_body
      {
        targetLanguageCode: target_language,
        texts:              [text],
        folderId:           YANDEX_FOLDER_ID
      }.to_json
    end

    def build_request
      request = Net::HTTP::Post.new(API_URI)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Api-Key #{YANDEX_API_KEY}"
      request.body = build_body
      request
    end
  end
end
