require 'git/duet'
require 'optparse'
require 'pry'

module Git
  module Duet
    class Cli
      def self.start
        parser = OptionParser.new do |opts|
          opts.on '--add AUTHOR', 'Add an author. Format: "Author Name <author@example.com>"' do |author|
            key = author.split.first
            author = author.split[1..-1].join(' ')
            Wrapper.author = key, author
          end

          opts.on '--email EMAIL', 'Set email format. Format: dev@example.com' do |email|
            Wrapper.email_format = email
          end

          opts.on '-h', 'Show this message' do
            puts opts
            exit
          end
        end.parse!

        unless ARGV.empty?
          authors = ARGV.sort.map do |key|
            author = Git::Duet::Wrapper.author(key)
            Git::Duet::Author.new(author, key)
          end
          Git::Duet::Pair.new(authors).set
        end

        puts Wrapper.current_committer
      end
    end
  end
end