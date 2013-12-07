require 'minitest/autorun'
require 'minitest/unit'
require "mocha/setup"
require 'pry'

$:<< File.dirname(__FILE__) + "/../lib"
require 'git/duo'

def alfred_and_bruce
  [
    Git::Duo::Author.import('bruce Bruce Wayne <bruce@gotham.travel>'),
    Git::Duo::Author.import('alfred Alfred Pennyworth <alfred@gotham.traval>')
  ]
end

def alfred_and_bruce_rachel
  alfred_and_bruce << Git::Duo::Author.import('rachel Rachel Dawes <rachel@gotham.travel>')
end

def jim_and_harvey
  [
    Git::Duo::Author.import('jim Jim Gordon <jim@gotham.travel>'),
    Git::Duo::Author.import('harvey Harvey Dent <harvey@gotham.travel>')
  ]
end

class DummyWrapper < Struct.new(:directory)
  def config(*)
    git_config
  end
end

def git_config
  [
    'git-duo.bruce Bruce Wayne <bruce@gotham.travel>',
    'git-duo.alfred Alfred Pennyworth <alfred@gotham.travel>',
    'git-duo.email board+%names@gotham.travel'
  ]
end
