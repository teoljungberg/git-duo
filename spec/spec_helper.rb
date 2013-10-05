require 'pry'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

def author
  OpenStruct.new key: 'teo',
    name: 'Teo Ljungberg',
    email: 'teo@mynewsdesk.com',
    full: 'Teo Ljungberg <teo@mynewsdesk.com>'
end
