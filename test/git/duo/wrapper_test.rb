require_relative '../../test_helper'

module Git
  module Duo
    class WrapperTest < MiniTest::Test
      def test_top_level
        directory = Wrapper.top_level

        expected_directory = File.expand_path('../../../../', __FILE__)
        assert_equal expected_directory, directory
      end

      def test_top_level_when_not_in_git
        assert_raises NotAGitRepository do
          Dir.chdir('/tmp') { Wrapper.top_level }
        end
      end
    end
  end
end
