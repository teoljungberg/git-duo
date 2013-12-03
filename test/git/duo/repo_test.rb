require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @repo = Repo.new '~/code/mynewsdesk', wrapper
    end
    attr_reader :repo

    def wrapper
      @wrapper ||= Minitest::Mock.new.
        expect(:config, alfred_and_bruce, ['--get-regexp git-duo'])
    end

    def test_initialize_expands_directory_path
      expected = repo.directory
      assert_equal expected, File.join(ENV['HOME'], 'code', 'mynewsdesk')
    end

    def test_authors_returns_user_objects
      assert_instance_of User, repo.authors.sample
      assert wrapper.verify
    end

    def test_email_returns_set_group_email
      assert_equal "batman+%names@gotham.travel", repo.email
      assert wrapper.verify
    end
  end
end
