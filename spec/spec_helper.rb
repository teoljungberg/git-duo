require 'git/duet/wrapper'
require 'ostruct'
require 'pry'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before { Git::Duet::Wrapper.stub(:email_format) { 'dev@mynewsdesk.com' } }
  config.before { Git::Duet::Wrapper.stub(:set_email) { author.email } }
  config.before { Git::Duet::Wrapper.stub(:email_name) { author.name } }
  config.before { Git::Duet::Wrapper.stub(:set_email=) { author.email } }
  config.before { Git::Duet::Wrapper.stub(:email_name=) { author.name } }
end

def author
  OpenStruct.new key: 'teo',
    name: 'Teo Ljungberg',
    email: 'teo@mynewsdesk.com',
    full: 'Teo Ljungberg <teo@mynewsdesk.com>'
end

def authors
  [
    OpenStruct.new(key: 'teo',
                   name: 'Teo Ljungberg',
                   email: 'teo@mynewsdesk.com',
                   full: 'Teo Ljungberg <teo@mynewsdesk.com>'),
    OpenStruct.new(key: 'billskog',
                   name: 'David Billskog',
                   email: 'david.billskog@mynewsdesk.com',
                   full: 'David Billskog <david.billskog@mynewsdesk.com>')
  ]
end
