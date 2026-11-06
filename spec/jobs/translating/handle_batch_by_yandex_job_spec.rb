require 'rails_helper'

RSpec.describe Translating::HandleBatchByYandexJob, type: :job do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }
  let(:source_file) { create(:source_file, batch: batch) }
  let!(:translation_key1) { create(:translation_key, game: game, source_file: source_file) }
  let!(:translation_key2) { create(:translation_key, game: game, source_file: source_file) }
  
  describe '#perform' do
    it 'enqueues TranslateKeyJob for each translation key' do
      expect {
        described_class.perform_now(batch.id, :en, :kjh)
      }.to have_enqueued_job(Translating::TranslateKeyJob).exactly(2).times
    end
    
    it 'enqueues CheckSourceFileTranslationCompleteJob for each source file' do
      expect {
        described_class.perform_now(batch.id, :en, :kjh)
      }.to have_enqueued_job(Translating::CheckSourceFileTranslationCompleteJob).with(source_file.id, batch.id).once
    end
    
    it 'marks batch as in_progress' do
      described_class.perform_now(batch.id, :en, :kjh)
      expect(batch.reload.state).to eq('in_progress')
    end
    
    it 'marks source file as translating' do
      described_class.perform_now(batch.id, :en, :kjh)
      expect(source_file.reload.status).to eq('translating')
    end
  end
end
