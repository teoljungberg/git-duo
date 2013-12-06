require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @repo ||= Repo.new '~/code/mynewsdesk', wrapper: DummyWrapper.new(:path_to_hell)
    end
    attr_reader :repo

    def test_initialize_expands_directory_path
      expected = repo.directory
      assert_equal expected, File.join(ENV['HOME'], 'code', 'mynewsdesk')
    end

    def test_authors_returns_user_objects
      assert_instance_of User, repo.authors.sample
    end

    def test_import_authors
      repo.authors = jim_and_harvey
      assert repo.save
    end

    def test_import_email
      repo.email = "law+%names@gotham.travel"
      assert repo.save
    end

    def test_email_returns_set_group_email
      assert_equal "board+%names@gotham.travel", repo.email
    end

    def test_save
      assert repo.save
    end
  end
end
