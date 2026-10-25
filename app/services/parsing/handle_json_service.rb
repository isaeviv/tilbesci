module Parsing
  class HandleJsonService < BaseService

    attr_reader :file_path, :locale, :game, :batch

    def initialize batch
      @file_path = batch.file.path
      @locale = batch.source_locale
      @game = batch.game
      @batch = batch
    end

    def call
      parse_json
    end

    def save_translations key_name:, value:
      translation_key = batch.translation_keys.find_or_create_by!(name: key_name, game_id: game.id)
      translation_key.translations.find_or_create_by!(locale: locale) do |t|
        t.value = value
      end
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
          service_instance.save_translations key_name: @current_key, value: v
        end
      end
    end
  end
end
