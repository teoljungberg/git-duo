require 'git/duet'
require 'optparse'

module Git
  module Duet
    class Cli
      COMMAND = 'config --get-regexp git-duet'

      def self.start
        parser = OptionParser.new do |opts|
          opts.on '--add AUTHOR', 'Add an author. Format: "Author Name <author@example.com>"' do |author|
            key = author.split.shift
            author = author.join ' '
            Wrapper.author = author, key
          end

          opts.on '--email EMAIL', 'Set email format. Format: dev@example.com' do |email_format|
            Wrapper.email = email_format
          end

          opts.on '--import=PATH/TO/REPO', 'Import pairs from another repo' do |repo|
            git_repo = File.join(File.expand_path(repo), '.git')
            config = Wrapper.repo(git_repo, COMMAND).split("\n")
            Import.new(config).perform
          end

          opts.on '-h', 'Show this message' do
            puts opts
            exit
          end
        end

        parser.parse!

        unless ARGV.empty?
          authors = ARGV.sort.map do |key|
            author = Wrapper.author(key)
            abort("`#{key}` can't be found, see --help on how to add new authors") if author.empty?
            Author.new(author, key)
          end
          Pair.new(authors).set
        end

        puts Wrapper.current_committer

      rescue OptionParser::MissingArgument
        abort "missing required argument\n\n #{parser.help}"
      end
    end
  end
end
