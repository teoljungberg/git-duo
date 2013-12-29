require_relative '../../../test_helper.rb'

module Git::Duo::CoreExtensions
  class ArrayTest < Minitest::Test
    def test_where_can_find_any_attribute
      refute_empty alfred_and_bruce.where(key: 'bruce')
      refute_empty alfred_and_bruce.where(name: 'alfred')
    end

    def test_where_is_case_insensitive
      refute_empty alfred_and_bruce.where(key: 'brUCE')
    end

    def test_where_returns_empty_array_if_nothing_is_matched
      assert_empty alfred_and_bruce.where(name: 'Joker')
    end
  end
end
