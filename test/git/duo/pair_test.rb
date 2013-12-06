require_relative '../../test_helper'

module Git::Duo
  class PairTest < MiniTest::Test
    def setup
      @pair ||= Pair.new alfred_and_bruce, "board+%names@gotham.com", wrapper: DummyWrapper.new(:path_to_hell)
    end
    attr_reader :pair

    def test_name
      expected = 'Alfred Pennyworth + Bruce Wayne'
      assert_equal expected, pair.name
    end

    def test_email
      expected = 'board+alfred+bruce@gotham.com'
      assert_equal expected, pair.email
    end

    def test_to_s
      expected = 'Alfred Pennyworth + Bruce Wayne <board+alfred+bruce@gotham.com>'
      assert_equal expected, pair.to_s
    end

    def test_inspect_is_to_s
      assert_equal pair.to_s, pair.inspect
    end

    def test_save
      assert pair.save
    end
  end
end