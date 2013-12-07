require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @wrapper = DummyWrapper.new(:path_to_hell)
      @repo ||= Repo.new '~/code/mynewsdesk', wrapper: wrapper
    end
    attr_reader :repo, :wrapper

    def test_initialize_expands_directory_path
      expected = repo.directory
      assert_equal expected, File.join(ENV['HOME'], 'code', 'mynewsdesk')
    end

    def test_authors_returns_author_objects
      assert_instance_of Author, repo.authors.sample
    end

    def test_import_authors
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config)
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.jim 'Jim Gordon <jim@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.harvey 'Harvey Dent <harvey@gotham.travel>'")

      repo.authors = jim_and_harvey
      repo.save
    end

    def test_import_email
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config)
      wrapper.expects(:config).with("git-duo.email 'law+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.email = "law+%names@gotham.travel"
      repo.save
    end

    def test_email_returns_set_group_email
      assert_equal "board+%names@gotham.travel", repo.email
    end

    def test_save
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.save
    end
  end
end
