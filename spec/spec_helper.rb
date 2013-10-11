require 'git/duet/repo'
require 'ostruct'
require 'pry'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before { Git::Duet::Repo.stub(:user_email) { author.email } }
  config.before { Git::Duet::Repo.stub(:user_name) { author.name } }
end

def author
  OpenStruct.new key: 'teo',
    name: 'Teo Ljungberg',
    email: 'teo@mynewsdesk.com',
    full: 'Teo Ljungberg <teo@mynewsdesk.com>'
end

def config
  [
    'git-duet.email dev@mynewsdesk.com',
    'git-duet.teo Teo Ljungberg <teo@mynewsdesk.com>',
    'git-duet.billskog David Billskog <david.billskog@mynewsdesk.com>'
  ]
end

def config_authors
  [
    'git-duet.teo Teo Ljungberg <teo@mynewsdesk.com>',
    'git-duet.billskog David Billskog <david.billskog@mynewsdesk.com>'
  ]
end

def config_email
  'git-duet.email dev@mynewsdesk.com'
end


def authors
  [
    OpenStruct.new(key: 'billskog',
                   name: 'David Billskog',
                   email: 'david.billskog@mynewsdesk.com',
                   full: 'David Billskog <david.billskog@mynewsdesk.com>'),
    OpenStruct.new(key: 'teo',
                   name: 'Teo Ljungberg',
                   email: 'teo@mynewsdesk.com',
                   full: 'Teo Ljungberg <teo@mynewsdesk.com>')
  ]
end

def pair_name
  'David Billskog and Teo Ljungberg'
end

def pair_email
  'dev+billskog+teo@mynewsdesk.com'
end
