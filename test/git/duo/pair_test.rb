require_relative '../../test_helper'

module Git::Duo
  class PairTest < MiniTest::Test
    def setup
      @wrapper = DummyWrapper.new(:path_to_hell)
      @pair ||= Pair.new alfred_and_bruce, "board+%names@gotham.travel", wrapper: wrapper
    end
    attr_reader :pair, :wrapper

    def test_destroy
      Wrapper.any_instance.expects(:config).with('--remove-section user')

      Pair.destroy
    end

    def test_supports_multiple_authors
      pair = Pair.new alfred_and_bruce_rachel, "board+%names@gotham.travel"
      expected_name = "Alfred Pennyworth + Bruce Wayne + Rachel Dawes"
      expected_email = "board+alfred+bruce+rachel@gotham.travel"

      assert_equal expected_name, pair.name
      assert_equal expected_email, pair.email
    end

    def test_name
      expected = 'Alfred Pennyworth + Bruce Wayne'
      assert_equal expected, pair.name
    end

    def test_email
      expected = 'board+alfred+bruce@gotham.travel'
      assert_equal expected, pair.email
    end

    def test_to_s
      expected = 'Alfred Pennyworth + Bruce Wayne <board+alfred+bruce@gotham.travel>'
      assert_equal expected, pair.to_s
    end

    def test_inspect_is_to_s
      assert_equal pair.to_s, pair.inspect
    end

    def test_save
      wrapper.expects(:config).with("user.email 'board+alfred+bruce@gotham.travel'")
      wrapper.expects(:config).with("user.name 'Alfred Pennyworth + Bruce Wayne'")

      pair.save
    end
  end
end
