require 'git/duo'
require 'ostruct'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'

  config.before { Git::Duo::Repo.stub(:user_email) { author.email } }
  config.before { Git::Duo::Repo.stub(:user_name) { author.name } }
  config.before { Git::Duo::Repo.any_instance.stub(:command) }
end

def author
  Author.import 'teo Teo Ljungberg <teo@mynewsdesk.com>'
end

def config
  [
    'git-duo.email dev@mynewsdesk.com',
    'git-duo.teo Teo Ljungberg <teo@mynewsdesk.com>',
    'git-duo.billskog David Billskog <david.billskog@mynewsdesk.com>'
  ]
end

def config_authors
  [
    'git-duo.teo Teo Ljungberg <teo@mynewsdesk.com>',
    'git-duo.billskog David Billskog <david.billskog@mynewsdesk.com>'
  ]
end

def config_email
  'git-duo.email dev@mynewsdesk.com'
end


def authors
  [
    Git::Duo::Author.import('billskog David Billskog <david.billskog@mynewsdesk.com>'),
    Git::Duo::Author.import('teo Teo Ljungberg <teo@mynewsdesk.com>')
  ]
end

def pair_name
  'David Billskog and Teo Ljungberg'
end

def pair_email
  'dev+billskog+teo@mynewsdesk.com'
end
