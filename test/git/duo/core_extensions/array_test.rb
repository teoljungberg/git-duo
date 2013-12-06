require_relative '../../../test_helper.rb'

module Git
  module Duo
    module CoreExtensions
      class ArrayTest < Minitest::Test
        def test_where_can_find_any_attribute
          refute_empty alfred_and_bruce.where(key: 'brUCE')
          refute_empty alfred_and_bruce.where(name: 'Alfred')
        end

        def test_where_returns_empty_array_if_nothing_is_matched
          assert_empty alfred_and_bruce.where(name: 'Joker')
        end
      end
    end
  end
end
