require_relative '../../test_helper'
require 'git/duo/author_collection'

module Git::Duo
  class AuthorCollectionTest < Minitest::Test
    def setup
      @collection = AuthorCollection.new alfred_and_bruce
    end
    attr_reader :collection

    def test_where
      refute_predicate collection.where(key: 'alfred'), :empty?
      assert_instance_of Author, collection.where(key: 'alfred').first
    end

    def test_where_partial_match
      search = collection.where(key: 'alf')
      result = search.first

      refute_predicate search, :empty?
      assert_equal "Alfred Pennyworth", result.name
    end

    def test_where_with_nonexisting_keys
      assert_empty collection.where(omg: 0)
    end

    def test_where_with_no_given_query
      assert_empty collection.where
    end
  end
end
