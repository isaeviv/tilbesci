module Translating
  class HandleBatchByYandexJob < ApplicationJob
    queue_as :default

    def perform(batch_id, source_locale, target_locale)
      batch = Batch.find(batch_id)
      batch.mark_as_in_progress!

      batch.source_files.find_each do |source_file|
        source_file.mark_as_translating!
        
        source_file.translation_keys.find_each do |translation_key|
          TranslateKeyJob.perform_later(translation_key.id, source_locale, target_locale)
        end
        
        CheckSourceFileTranslationCompleteJob.perform_later(source_file.id, batch.id)
      end
    end
  end
end
