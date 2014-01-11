require_relative '../../test_helper'

module Git::Duo
  class PairTest < MiniTest::Test
    def setup
      @wrapper = DummyWrapper.new(:path_to_hell)
      @pair = Pair.new alfred_and_bruce, wrapper: wrapper
    end
    attr_reader :pair, :wrapper

    def test_pair_supports_multiple_authors
      wrapper.expects(:config).with("git-duo.email").
        returns(["board+%names@gotham.travel"]).at_least_once

      pair = Pair.new alfred_and_bruce_rachel, wrapper: wrapper
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
      wrapper.expects(:config).with("git-duo.email").
        returns(["board+%names@gotham.travel"]).at_least_once

      expected = 'board+alfred+bruce@gotham.travel'
      assert_equal expected, pair.email
    end

    def test_email_raises_error_if_not_implemented
      wrapper.expects(:config).with("git-duo.email").
        returns([]).at_least_once

      assert_raises Git::Duo::EmailNotImplemented do
        pair.email
      end
    end

    def test_to_s
      wrapper.expects(:config).with("git-duo.email").
        returns(["board+%names@gotham.travel"]).at_least_once

      expected = 'Alfred Pennyworth + Bruce Wayne <board+alfred+bruce@gotham.travel>'
      assert_equal expected, pair.to_s
    end

    def test_inspect_is_to_s
      assert_equal pair.to_s, pair.inspect
    end

    def test_save
      wrapper.expects(:config).with("git-duo.email").
        returns(["board+%names@gotham.travel"]).at_least_once

      wrapper.expects(:config).with("user.email 'board+alfred+bruce@gotham.travel'")
      wrapper.expects(:config).with("user.name 'Alfred Pennyworth + Bruce Wayne'")

      pair.save
    end
  end
end
