require 'rails_helper'

RSpec.describe Translating::TranslateKeyService, type: :service do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }
  let(:source_file) { create(:source_file, batch: batch) }
  let(:translation_key) { create(:translation_key, game: game, source_file: source_file) }
  
  describe '#call' do
    context 'when source translation exists and is valid' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: 'Hello world')
      end
      
      it 'translates and saves target translation', vcr: { cassette_name: 'yandex_translate' } do
        described_class.new(translation_key, :en, :kjh).call
        
        target_translation = translation_key.translations.with_locale(:kjh).first
        expect(target_translation).to be_present
        expect(target_translation.value).to be_present
      end
    end
    
    context 'when source translation is blank' do
      it 'does not call Yandex API' do
        expect(Translating::YandexService).not_to receive(:new)
        described_class.new(translation_key, :en, :kjh).call
      end
    end
    
    context 'when source translation contains only digits' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: '12345')
      end
      
      it 'does not call Yandex API' do
        expect(Translating::YandexService).not_to receive(:new)
        described_class.new(translation_key, :en, :kjh).call
      end
    end
    
    context 'when source translation contains only special characters' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: '!@#$%^&*()')
      end
      
      it 'does not call Yandex API' do
        expect(Translating::YandexService).not_to receive(:new)
        described_class.new(translation_key, :en, :kjh).call
      end
    end
    
    context 'when source translation contains digits with spaces' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: '123 456 789')
      end
      
      it 'does not call Yandex API' do
        expect(Translating::YandexService).not_to receive(:new)
        described_class.new(translation_key, :en, :kjh).call
      end
    end
    
    context 'when source translation contains letters mixed with digits' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: 'test123')
      end
      
      it 'calls Yandex API', vcr: { cassette_name: 'yandex_translate' } do
        expect(Translating::YandexService).to receive(:new).and_call_original
        described_class.new(translation_key, :en, :kjh).call
      end
    end
    
    context 'when Yandex API raises error' do
      let!(:source_translation) do
        create(:translation, translation_key: translation_key, locale: :en, value: 'Hello')
      end
      
      it 'logs error and does not raise', vcr: { cassette_name: 'yandex_translate_failure' } do
        expect(Rails.logger).to receive(:error).at_least(:once)
        expect { described_class.new(translation_key, :en, :kjh).call }.not_to raise_error
      end
    end
  end
end
