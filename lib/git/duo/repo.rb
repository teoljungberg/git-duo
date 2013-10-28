require 'git/duo/author'

module Git
  module Duo
    class Repo
      EMAIL_KEY_REGEXP = /^(.*email).*$/

      def initialize repo
        @repo = File.expand_path(repo)
      end

      def author= author
        command 'config', "git-duo.#{author.key} '#{author.name} <#{author.email}>'"
      end

      def author key
        command 'config', "git-duo.#{key}"
      end

      def authors
        filter_authors(raw_duo_config).map do |author_string|
          Author.import extract_raw_author(author_string)
        end.sort_by { |author| author.key }
      end

      def authors= authors
        authors.each do |author|
          self.author = Author.import author.to_s
        end
      end

      def email
        filter_email raw_duo_config
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
      attr_reader :repo

      %w(user_email user_name).each do |method|
        define_method(method) { command 'config', "#{method.gsub(?_, ?.)}" }
        define_method(method + ?=) { |new_value| command 'config', "#{method.gsub(?_, ?.)} '#{new_value}'" }
      end

      def group_email= email
        command 'config', "git-duo.email '#{email}'"
      end

      def command *args
        `git #{args.join(' ')} 2>&1`.strip
      end

      def raw_duo_config
        command(list_duo_config).split("\n")
      end

      def list_duo_config
        ["--git-dir=#{git_repo}", "config", "--get-regexp git-duo."]
      end

      def filter_authors output
        output.reject {|a| a.match EMAIL_KEY_REGEXP }
      end

      def filter_email output
        output.select {|a| a.match EMAIL_KEY_REGEXP }.shift
      end

      def extract_raw_author string
        string.split('git-duo.')[1..-1].join ' '
      end

      def extract_email string
        string.split('git-duo.').pop.split(' ').pop
      end

      def git_repo
        File.join repo, '.git'
      end
    end
  end
end
