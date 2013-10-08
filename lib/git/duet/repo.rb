require 'git/duet/wrapper'

module Git
  module Duet
    class Repo
      EMAIL_KEY_REGEXP = /^(.*email).*$/

      attr_reader :repo

      def initialize repo
        @repo = File.expand_path(repo)
      end

      def authors
        filter_authors config
      end

      def authors= imported_authors
        imported_authors.each do |import_string|
          raw_author = extract_raw_author import_string
          Wrapper.author = Author.import raw_author
        end
      end

      def email
        filter_email config
      end

      def email= imported_emails
        imported_emails.each do |string|
          Wrapper.email = extract_email string
        end
      end

      private

      def command *args
        `git #{args.join(' ')}`.strip
      end

      def config
        command(list_duet_config).split("\n")
      end

      def list_duet_config
        ["--git-dir=#{git_repo}", "config", "--get-regexp git-duet."]
      end

      def filter_authors output
        output.reject {|a| a.match EMAIL_KEY_REGEXP }
      end

      def filter_email output
        output.select {|a| a.match EMAIL_KEY_REGEXP }
      end

      def extract_raw_author string
        string.split('git-duet.')[1..-1].join ' '
      end

      def extract_email string
        string.split('git-duet.').pop.split(' ').pop
      end

      def git_repo
        File.join @repo, '.git'
      end
    end
  end
end
