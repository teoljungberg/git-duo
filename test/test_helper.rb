require 'minitest/autorun'
require "mocha/setup"
require 'git/duo'

def alfred_and_bruce
  [
    Git::Duo::Author.import('alfred Alfred Pennyworth <alfred@gotham.travel>'),
    Git::Duo::Author.import('bruce Bruce Wayne <bruce@gotham.travel>')
  ]
end

def alfred_and_bruce_rachel
  alfred_and_bruce << Git::Duo::Author.import('rachel Rachel Dawes <rachel@gotham.travel>')
end

def bruce_and_edward
  [
    Git::Duo::Author.import('bruce Bruce Wayne <bruce@gotham.travel>'),
    Git::Duo::Author.import('riddler Edward Nigma <riddler@guess.com>')
  ]
end

def jim_and_harvey
  [
    Git::Duo::Author.import('jim Jim Gordon <jim@gotham.travel>'),
    Git::Duo::Author.import('harvey Harvey Dent <harvey@gotham.travel>')
  ]
end

def alexander_and_al
  [
    Git::Duo::Author.import('alexander Alexander Knox <alexander@gotham.travel>'),
    Git::Duo::Author.import('al Alfred Pennyworth <alfred@gotham.travel>')
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
