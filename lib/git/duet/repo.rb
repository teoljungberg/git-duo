require 'git/duet/repo'

module Git
  module Duet
    class Repo
      EMAIL_KEY_REGEXP = /^(.*email).*$/

      attr_reader :repo

      def initialize repo
        @repo = File.expand_path(repo)
      end

      def author= author
        command 'config', "git-duet.#{author.key} '#{author}'"
      end

      def author key
        command 'config', "git-duet.#{key}"
      end

      def authors
        filter_authors raw_duet_config
      end

      def authors= imported_authors
        imported_authors.each do |import_string|
          raw_author = extract_raw_author import_string
          self.author = Author.import raw_author
        end
      end

      def email
        filter_email raw_duet_config
      end

      def email= imported_email
        self.group_email = extract_email imported_email
      end

      def unpair!
        command 'config', '--remove-section user'
        current_committer
      end

      def current_committer
        "#{user_name} <#{user_email}>"
      end

      private

      %w(user_email user_name).each do |method|
        define_method(method) { command 'config', "#{method.gsub(?_, ?.)}" }
        define_method(method + ?=) { |new_value| command 'config', "#{method.gsub(?_, ?.)} '#{new_value}'" }
      end

      def group_email= email
        command 'config', "git-duet.email '#{email}'"
      end

      def command *args
        `git #{args.join(' ')}`.strip
      end

      def raw_duet_config
        command(list_duet_config).split("\n")
      end

      def list_duet_config
        ["--git-dir=#{git_repo}", "config", "--get-regexp git-duet."]
      end

      def filter_authors output
        output.reject {|a| a.match EMAIL_KEY_REGEXP }
      end

      def filter_email output
        output.select {|a| a.match EMAIL_KEY_REGEXP }.shift
      end

      def extract_raw_author string
        string.split('git-duet.')[1..-1].join ' '
      end

      def extract_email string
        string.split('git-duet.').pop.split(' ').pop
      end

      def git_repo
        File.join repo, '.git'
      end
    end
  end
end
