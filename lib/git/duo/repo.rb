require 'git/duo/wrapper'

module Git
  module Duo
    class Repo
      attr_reader :directory, :wrapper

      def initialize(directory, opts = {})
        @directory = File.expand_path(directory)
        @wrapper = opts.fetch(:wrapper) { Git::Duo::Wrapper.new(git_directory) }
      end

      def authors
        return @authors if defined? @authors
        config.
          reject {|key| non_git_author? key }.
          map {|a| Git::Duo::User.import(a) }
      end

      def authors=(new_authors)
        @authors = new_authors
      end

      def email
        return @email if defined? @email
        config.
          select {|key| non_git_author? key }.
          map {|key| key.gsub(/^email\s/, '') }.
          first
      end

      def email=(new_email)
        @email = new_email
      end

      def save
        save_email
        save_authors
      end

      private

      def non_git_author?(key)
        key =~ /email/
      end

      def save_authors
        authors.each do |author|
          wrapper.config "git-duo.#{author.key} '#{author}'"
        end
      end

      def save_email
        wrapper.config "git-duo.email '#{email}'"
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
  end
end
