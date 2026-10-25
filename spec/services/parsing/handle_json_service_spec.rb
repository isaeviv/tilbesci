require 'rails_helper'

RSpec.describe "Parsing::HandleJsonService", type: :service do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }

  describe "#call" do
    it "parses the JSON file and creates translation keys and translations" do
      service = Parsing::HandleJsonService.new(batch)
      service.call

      expect(batch.translation_keys.count).to eq(2)
      expect(batch.translations.count).to eq(2)
    end
  end
end
