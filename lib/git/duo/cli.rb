require 'git/duo'
require 'optparse'

module Git
  module Duo
    class CLI
      def self.start
        puts current_repo.current_committer if ARGV.empty?

        parser = OptionParser.new do |opts|
          opts.on '--add AUTHOR', 'Add an author. Format: "Key Author Name <author@example.com>"' do |string|
            author = Author.import string
            current_repo.author = author
          end

          opts.on '--email EMAIL', 'Set email format. Format: dev@example.com' do |email_format|
            current_repo.email = email_format
          end

          opts.on '--import=PATH/TO/REPO', 'Import pairs from another repo' do |repo|
            import_repo = Repo.new(repo)
            current_repo.email = import_repo.email
            current_repo.authors = import_repo.authors
          end

          opts.on '-h', 'Show this message' do
            puts opts
            exit
          end
        end

        parser.parse!

        unless ARGV.empty?
          authors = ARGV.sort.map do |key|
            author = current_repo.author(key)
            abort("`#{key}` can't be found, see --help on how to add new authors") if author.empty?
            Author.new(author, key)
          end
          Pair.new(authors).set
          puts current_repo.current_committer
        end

      rescue OptionParser::MissingArgument
        abort "missing required argument\n\n #{parser.help}"
      end

      private

      def self.current_repo
        @_current_repo ||= Repo.new(Dir.pwd)
      end
    end
  end
end
