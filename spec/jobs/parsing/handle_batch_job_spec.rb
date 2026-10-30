require 'rails_helper'

RSpec.describe Parsing::HandleBatchJob, type: :job do
  let(:game) { create(:game) }
  let(:batch) { create(:batch, game: game) }

  describe "#perform" do
    context "when batch has multiple source files" do
      let!(:source_file1) { create(:source_file, batch: batch) }
      let!(:source_file2) { create(:source_file, batch: batch) }

      it "enqueues HandleSourceFileJob for each source file" do
        expect {
          described_class.new.perform(batch.id)
        }.to have_enqueued_job(Parsing::HandleSourceFileJob).twice
      end
    end

    context "when batch has no source files" do
      it "does not enqueue any jobs" do
        expect {
          described_class.new.perform(batch.id)
        }.not_to have_enqueued_job(Parsing::HandleSourceFileJob)
      end
    end
  end
end
