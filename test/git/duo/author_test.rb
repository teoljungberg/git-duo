require_relative '../../test_helper'

module Git::Duo
  class AuthorTest < MiniTest::Test
    def setup
      @author = Author.new(author_options)
    end
    attr_reader :author

    def author_options
      {
        key: 'alfred',
        name: 'Alfred Pennyworth',
        email: 'alfred@gotham.travel'
      }
    end

    def test_author_requires_name
      author = Author.new author_options.merge(name: nil)

      refute_predicate author, :valid?
    end

    def test_author_requires_email
      author = Author.new author_options.merge(email: nil)

      refute_predicate author, :valid?
    end

    def test_author_requires_key
      author = Author.new author_options.merge(key: nil)

      refute_predicate author, :valid?
    end

    def test_import
      author = Author.import("bruce Bruce Wayne <bruce@gotham.travel>")

      assert_predicate author, :valid?
    end

    def test_import_without_key
      author = Author.import("Bruce Wayne <bruce@gotham.travel>")

      assert_predicate author, :valid?
      assert_equal "bruce", author.key
    end

    def test_to_s
      expected = "Alfred Pennyworth <alfred@gotham.travel>"

      assert_equal expected, author.to_s
    end
  end
end
