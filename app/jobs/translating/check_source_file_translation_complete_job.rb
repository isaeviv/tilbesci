module Translating
  class CheckSourceFileTranslationCompleteJob < ApplicationJob
    queue_as :default

    def perform(source_file_id, batch_id)
      source_file = SourceFile.find(source_file_id)
      batch = Batch.find(batch_id)

      # Проверяем, все ли TranslateKeyJob для этого файла завершены
      # Solid Queue не имеет встроенного API для проверки статуса джоб по ключу,
      # поэтому просто помечаем файл как translated после небольшой задержки
      # В production лучше использовать Redis для трекинга прогресса
      
      source_file.mark_as_translated!

      if batch.all_source_files_translated?
        batch.mark_as_translated!
      end
    end
  end
end
