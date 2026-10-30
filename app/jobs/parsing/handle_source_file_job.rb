module Parsing
  class HandleSourceFileJob < ApplicationJob
    queue_as :default

    def perform(source_file_id)
      source_file = SourceFile.find(source_file_id)
      Parsing::HandleJsonService.new(source_file).call
    end
  end
end
