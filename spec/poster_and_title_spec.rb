require './posters_and_title'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  # Указываем где будем хранить наши кассеты )
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  # Интегрируемся с webmock 
  config.hook_into :webmock
end

