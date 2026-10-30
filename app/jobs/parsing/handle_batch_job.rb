module Parsing
  class HandleBatchJob < ApplicationJob
    queue_as :default

    def perform(batch_id)
      batch = Batch.find(batch_id)
      batch.source_files.with_status(:pending, :failed).find_each do |source_file|
        Parsing::HandleSourceFileJob.perform_later(source_file.id)
      end
    end
  end
end
