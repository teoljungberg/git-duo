require 'git/duo/wrapper'

class Git::Duo::Repo
  attr_reader :directory, :wrapper

  def initialize(directory, wrapper = nil)
    @directory = File.expand_path(directory)
    @wrapper = wrapper || Git::Duo::Wrapper.new(git_directory)
  end

  def authors
    config.
      reject {|key| non_git_author? key }.
      map {|a| Git::Duo::User.import(a) }
  end

  def email
    config.
      select {|key| non_git_author? key }.
      map {|key| key.gsub(/^email\s/, '') }.
      first
  end

  private

  def non_git_author?(key)
    key =~ /email/
  end

  def config
    @config ||= wrapper.
      config('--get-regexp git-duo').
      select {|key| key.start_with? 'git-duo' }.
      map {|config| config.gsub('git-duo.', '') }
  end

  def git_directory
    File.join(directory, '.git')
  end
end
