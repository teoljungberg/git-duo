require_relative '../../test_helper'
require 'git/duo/author_collection'

module Git::Duo
  class AuthorCollectionTest < Minitest::Test
    def setup
      @collection = AuthorCollection.new alfred_and_bruce
    end
    attr_reader :collection

    def test_where_with_existing_keys
      refute_empty collection.where(key: 'alfred')
    end

    def test_where_with_nonexisting_keys_returns_empty_array
      assert_empty collection.where(omg: 0)
    end

    def test_where_returns_the_result_of_the_valid_query
      refute_empty collection.where(key: 'alfred', omg: 0)
      refute_empty collection.where(omg: 0, key: 'alfred')
    end
  end
end
