module Parsing
  class HandleJsonService < BaseService

    attr_reader :source_file, :file_path, :locale, :game, :batch

    def initialize(source_file)
      @source_file = source_file
      @file_path = source_file.file.path
      @batch = source_file.batch
      @locale = batch.source_locale
      @game = batch.game
    end

    def call
      log_event "#call", ""
      source_file.update!(status: :processing)
      parse_json
      source_file.update!(status: :processed)
    rescue => e
      source_file.update!(status: :failed)
      Rails.logger.error("!!! JSON parsing error for file: '#{source_file.file.identifier}'. error: '#{e.message}' !!!")
      raise
    end

    def save_translations(key_name:, value:)
      translation_key = batch.translation_keys.find_or_create_by!(name: key_name, game_id: game.id, source_file: source_file)
      translation = translation_key.translations.find_or_initialize_by(locale: locale)
      translation.value = value
      translation.save!
      log_event "save_translation", {locale: locale, key: translation_key.name, value: value}
    rescue => e
      Rails.logger.error("!!! JSON parsing error for key: '#{key_name}'. value: '#{value}'. error: '#{e.message}' !!!")
    end

    private

    def parse_json
      File.open(file_path, 'r') do |file|
        parser << file.read
      end
    end

    def parser
      service_instance = self
      JSON::Stream::Parser.new do
        key { |k| @current_key = k }
        value do |v|
          service_instance.save_translations(key_name: @current_key, value: v)
        end
      end
    end
  end
end
