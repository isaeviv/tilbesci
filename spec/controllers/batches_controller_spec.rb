require 'rails_helper'

RSpec.describe BatchesController, type: :controller do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }
  
  describe 'POST #translate' do
    let(:source_locale) { 'en' }
    let(:target_locale) { 'kjh' }
    
    before do
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'ru'
    end
    
    it 'enqueues HandleBatchByYandexJob' do
      expect {
        post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
      }.to have_enqueued_job(Translating::HandleBatchByYandexJob).with(batch.id, source_locale, target_locale)
    end
    
    it 'redirects to batch with notice' do
      post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
      expect(response).to redirect_to(batch)
      expect(flash[:notice]).to be_present
    end
    
    context 'when batch is already in_progress' do
      before { batch.update!(state: :in_progress) }
      
      it 'does not enqueue job' do
        expect {
          post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
        }.not_to have_enqueued_job(Translating::HandleBatchByYandexJob)
      end
      
      it 'redirects with alert' do
        post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
        expect(response).to redirect_to(batch)
        expect(flash[:alert]).to be_present
      end
    end
    
    context 'when batch is already translated' do
      before { batch.update!(state: :translated) }
      
      it 'does not enqueue job' do
        expect {
          post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
        }.not_to have_enqueued_job(Translating::HandleBatchByYandexJob)
      end
      
      it 'redirects with alert' do
        post :translate, params: { id: batch.id, source_locale: source_locale, target_locale: target_locale }
        expect(response).to redirect_to(batch)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
