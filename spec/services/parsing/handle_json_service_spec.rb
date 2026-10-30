require 'rails_helper'

RSpec.describe Parsing::HandleJsonService, type: :service do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game, source_locale: :en) }
  let(:source_file) { create(:source_file, batch: batch) }

  describe "#call" do
    it "parses the JSON file and creates translation keys and translations" do
      described_class.new(source_file).call

      expect(source_file.reload.status).to eq("processed")
      expect(batch.translation_keys.count).to eq(2)
      expect(batch.translations.count).to eq(2)
    end

    it "links translation keys to the source file" do
      described_class.new(source_file).call

      expect(batch.translation_keys.pluck(:source_file_id).uniq).to eq([source_file.id])
    end

    it "sets status to processing then processed" do
      service = described_class.new(source_file)

      expect { service.call }.to change { source_file.reload.status }.from("pending").to("processed")
    end

    it "updates translation values on re-parse" do
      described_class.new(source_file).call
      translation = batch.translations.find_by(locale: :en, translation_key: batch.translation_keys.find_by(name: "test_key"))
      expect(translation.value).to eq("test_value")

      File.write(source_file.file.path, '{"test_key": "updated_value"}')
      described_class.new(source_file).call

      expect(translation.reload.value).to eq("updated_value")
    end

    context "when parsing fails" do
      it "sets status to failed" do
        File.write(source_file.file.path, "not valid json{{{")

        described_class.new(source_file).call rescue nil

        expect(source_file.reload.status).to eq("failed")
      end
    end
  end
end
