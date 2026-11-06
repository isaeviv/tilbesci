require 'rails_helper'

RSpec.describe Translating::YandexService, type: :service do
  describe '#call' do
    it 'returns translations from Yandex Translate API', vcr: { cassette_name: 'yandex_translate' } do
      result = described_class.new('Привет братишка!', 'kjh').call

      expect(result).to eq({
        'translations' => [
          {
            'text' => 'Изен харындас!',
            'detectedLanguageCode' => 'ru'
          }
        ]
      })
    end

    it 'raise error', vcr: { cassette_name: 'yandex_translate_failure' }  do
      expect { described_class.new(1, 'kjh').call }.to raise_error
    end
  end
end
