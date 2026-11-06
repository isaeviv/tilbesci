require 'rails_helper'

RSpec.describe Translating::TranslateKeyJob, type: :job do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }
  let(:source_file) { create(:source_file, batch: batch) }
  let(:translation_key) { create(:translation_key, game: game, source_file: source_file) }
  
  describe '#perform' do
    it 'calls TranslateKeyService with correct arguments' do
      service_double = instance_double(Translating::TranslateKeyService, call: nil)
      allow(Translating::TranslateKeyService).to receive(:new).with(translation_key, :en, :kjh).and_return(service_double)
      
      described_class.perform_now(translation_key.id, :en, :kjh)
      
      expect(service_double).to have_received(:call)
    end
  end
end
