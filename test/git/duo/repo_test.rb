require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @wrapper = DummyWrapper.new(:path_to_hell)
      @repo = Repo.new '~/code/mynewsdesk', wrapper: wrapper
    end
    attr_reader :repo, :wrapper

    def test_current_inits_repo_with_current_dir
      expected = Dir.pwd

      Dir.chdir('test') do
        repo = Repo.current

        assert_equal expected, repo.directory
      end
    end

    def test_initialize_expands_directory_path
      expected = repo.directory
      assert_equal expected, File.join(ENV['HOME'], 'code', 'mynewsdesk')
    end

    def test_authors_returns_author_objects
      assert_instance_of Author, repo.authors.sample
    end

    def test_equals_equals_imports_authors
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.jim 'Jim Gordon <jim@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.harvey 'Harvey Dent <harvey@gotham.travel>'")

      repo.authors = jim_and_harvey
      repo.save
    end

    def test_authors_equals_supports_one_author
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.authors = Git::Duo::Author.import('bruce Bruce Wayne <bruce@gotham.travel>')
      repo.save
    end

    def test_committer
      wrapper.expects(:config).with('user.name').returns ["Bruce Wayne"]
      wrapper.expects(:config).with('user.email').returns ["bruce@gotham.travel"]

      expected = "Bruce Wayne <bruce@gotham.travel>"
      assert_equal expected, repo.committer
    end

    def test_importing_email
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'law+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.email = "law+%names@gotham.travel"
      repo.save
    end

    def test_email_returns_set_group_email
      assert_equal "board+%names@gotham.travel", repo.email
    end

    def test_solo_bang_resets_the_pair
      wrapper.expects(:config).with('--remove-section user')

      repo.solo!
    end

    def test_save
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")
      wrapper.expects(:config).with("git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.save
    end

    def test_save_doesnt_save_email_if_nil
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'")
      wrapper.expects(:config).with("git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'")

      repo.email = nil
      repo.save
    end

    def test_save_doesnt_save_authors_if_empty
      wrapper.expects(:config).with('--get-regexp git-duo').returns(git_config).at_least_once
      wrapper.expects(:config).with("git-duo.email 'board+%names@gotham.travel'")

      repo.authors = []
      repo.save
    end
  end
end
