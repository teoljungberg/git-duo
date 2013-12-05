require_relative '../../test_helper'

module Git::Duo
  class RepoTest < MiniTest::Test
    def setup
      @repo ||= Repo.new '~/code/mynewsdesk', wrapper: wrapper
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

    def test_import_authors_and_email
      wrapper = Minitest::Mock.new.
        expect(:config, :nope, ["git-duo.email 'law+%names@gotham.travel'"]).
        expect(:config, :nope, ["git-duo.jim 'Jim Gordon <jim@gotham.travel>'"]).
        expect(:config, :nope, ["git-duo.harvey 'Harvey Dent <harvey@gotham.travel>'"])

      repo = Repo.new '~/code/mynewsdesk', wrapper: wrapper
      repo.authors = jim_and_harvey
      repo.email = "law+%names@gotham.travel"
      repo.save

      assert wrapper.verify
    end

    def test_email_returns_set_group_email
      assert_equal "board+%names@gotham.travel", repo.email
      assert wrapper.verify
    end

    def test_save
      new_wrapper = wrapper.
        expect(:config, :nope, ["git-duo.email 'board+%names@gotham.travel'"]).
        expect(:config, :nope, ["git-duo.bruce 'Bruce Wayne <bruce@gotham.travel>'"]).
        expect(:config, :nope, ["git-duo.alfred 'Alfred Pennyworth <alfred@gotham.travel>'"])
      repo = Repo.new '~/code/mynewsdesk', wrapper: new_wrapper

      repo.save
      assert new_wrapper.verify
    end
  end
end
