require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @repo = Repo.new '~/code/mynewsdesk'
    end
    attr_reader :repo

    def test_initialize_expands_directory_path
      assert_equal repo.directory, File.join(ENV['HOME'], 'code', 'mynewsdesk')
    end

    def test_authors_returns_user_objects
      wrapper = Minitest::Mock.new
      wrapper.expect(:config, alfred_and_bruce, ['--get-regexp git-duo'])
      repo = Repo.new('~/code/mynewsdesk', wrapper)

      assert_instance_of User, repo.authors.sample
      assert wrapper.verify
    end
  end
end
