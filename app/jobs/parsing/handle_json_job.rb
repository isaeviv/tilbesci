module Parsing
  class HandleJsonJob < ApplicationJob
    queue_as :default

    def perform(batch_id)
      batch = Batch.find(batch_id)
      service = Parsing::HandleJsonService.new(batch)
    end
  end
end
