require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/mock'
require 'pry'

$:<< File.dirname(__FILE__) + "/../lib"
require 'git/duo'

def alfred_and_bruce
  [
    'git-duo.bruce Bruce Wayne <bruce@gotham.travel>',
    'git-duo.alfred Alfred Pennyworth <alfred@gotham.travel>',
    'git-duo.email batman+%names@gotham.travel'
  ]
end
