require 'git/duet'
require 'ostruct'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'

  config.before { Git::Duet::Repo.stub(:user_email) { author.email } }
  config.before { Git::Duet::Repo.stub(:user_name) { author.name } }
  config.before { Git::Duet::Repo.any_instance.stub(:command) }
end

def author
  Author.import 'teo Teo Ljungberg <teo@mynewsdesk.com>'
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
    Git::Duet::Author.import('billskog David Billskog <david.billskog@mynewsdesk.com>'),
    Git::Duet::Author.import('teo Teo Ljungberg <teo@mynewsdesk.com>')
  ]
end

def pair_name
  'David Billskog and Teo Ljungberg'
end

def pair_email
  'dev+billskog+teo@mynewsdesk.com'
end
