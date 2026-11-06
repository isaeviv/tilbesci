require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join('spec/fixtures/vcr_cassettes')
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<YANDEX_API_KEY>') { Rails.application.credentials.dig(:yandex_api_key) }
  config.filter_sensitive_data('<YANDEX_FOLDER_ID>') { Rails.application.credentials.dig(:yandex_folder_id) }
end
