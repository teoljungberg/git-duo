require 'git/duo'
require 'optparse'

module Git
  module Duo
    class CLI
      def self.start
        parser = OptionParser.new do |opts|
          puts current_repo.committer if ARGV.empty?

          opts.on '--add AUTHOR', '-a AUTHOR', 'Add an author. Format: "key Firstname Lastname <author@example.com>"' do |string|
            current_repo.authors = Author.import string
          end

          opts.on '--list', '-l',  'Lists the authors in the repository' do
            puts current_repo.authors
          end

          opts.on '--email EMAIL', '-e EMAIL', 'Set email format. Format: dev@example.com' do |email|
            current_repo.email = email
          end

          opts.on '--import=PATH/TO/REPO', '-i PATH/TO/REPO', 'Import pairs from another repo' do |path|
            import_repo = Repo.new path
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
            author = AuthorCollection.new(current_repo.authors).
              where(key: key).first
            abort "`#{key}` can't be found, see -h on how to add new authors" unless author
            Author.new(key: author.key, name: author.name, email: author.email)
          end
          pair = Pair.new authors
          pair.save
          puts pair.to_s
        end

        current_repo.save
      rescue OptionParser::MissingArgument
        abort "missing required argument\n\n #{parser.help}"
      rescue Git::Duo::EmailNotImplementedError
        abort "`Email format isn't set, see -h on how to set the email format"
      rescue Git::Duo::NotAGitRepository
        exit 1
      end

      private

      def self.current_repo
        @current_repo ||= Repo.current
      end
    end
  end
end
