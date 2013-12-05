require 'minitest/autorun'
require 'minitest/unit'
require 'pry'

$:<< File.dirname(__FILE__) + "/../lib"
require 'git/duo'

def alfred_and_bruce
  [
    Git::Duo::User.import('bruce Bruce Wayne <bruce@gotham.travel>'),
    Git::Duo::User.import('alfred Alfred Pennyworth <alfred@gotham.traval>')
  ]
end

def jim_and_harvey
  [
    Git::Duo::User.import('jim Jim Gordon <jim@gotham.travel>'),
    Git::Duo::User.import('harvey Harvey Dent <harvey@gotham.travel>')
  ]
end

class DummyWrapper < Struct.new(:directory)
  def config(*)
    [
      'git-duo.bruce Bruce Wayne <bruce@gotham.travel>',
      'git-duo.alfred Alfred Pennyworth <alfred@gotham.travel>',
      'git-duo.email board+%names@gotham.travel'
    ]
  end
end
