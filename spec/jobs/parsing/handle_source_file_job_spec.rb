require 'rails_helper'

RSpec.describe Parsing::HandleSourceFileJob, type: :job do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game, source_locale: :en) }
  let(:source_file) { create(:source_file, batch: batch) }

  describe "#perform" do
    it "calls HandleJsonService for the source file" do
      expect_any_instance_of(Parsing::HandleJsonService).to receive(:call)

      described_class.new.perform(source_file.id)
    end

    it "processes the file and updates status" do
      described_class.new.perform(source_file.id)

      expect(source_file.reload.status).to eq("processed")
    end
  end
end
