require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/mock'

$:<< File.dirname(__FILE__) + "/../lib"
require 'git/duo'

def alfred_and_bruce
  [
  'git-duo.bruce Bruce Wayne <batman@gotham.travel>',
  'git-duo.alfred Alfred Pennyworth <alfred@gotham.travel>'
  ]
end
