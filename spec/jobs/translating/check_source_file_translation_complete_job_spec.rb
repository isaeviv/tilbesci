require 'rails_helper'

RSpec.describe Translating::CheckSourceFileTranslationCompleteJob, type: :job do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }
  let(:source_file) { create(:source_file, batch: batch, status: :translating) }
  
  describe '#perform' do
    it 'marks source file as translated' do
      described_class.perform_now(source_file.id, batch.id)
      expect(source_file.reload.status).to eq('translated')
    end
    
    context 'when all source files are translated' do
      it 'marks batch as translated' do
        described_class.perform_now(source_file.id, batch.id)
        expect(batch.reload.state).to eq('translated')
      end
    end
    
    context 'when not all source files are translated' do
      let!(:source_file2) { create(:source_file, batch: batch, status: :translating) }
      
      it 'does not mark batch as translated' do
        described_class.perform_now(source_file.id, batch.id)
        expect(batch.reload.state).to eq('pending')
      end
    end
  end
end
