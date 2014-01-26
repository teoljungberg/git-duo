require 'git/duo/wrapper'
require 'git/duo/exceptions'

module Git
  module Duo
    class Pair
      attr_reader :authors, :wrapper

      def initialize authors, opts = {}
        @authors = authors.sort_by {|author| author.key }
        @wrapper = opts.fetch(:wrapper) { Git::Duo::Wrapper.new File.join(Dir.pwd, '.git') }
      end

      def name
        authors.map(&:name).join ' + '
      end

      def email
        if authors.size > 1
          base_email.gsub "%names", authors.map(&:key).join(?+)
        else
          authors.first.email
        end
      end

      def to_s
        "#{name} <#{email}>"
      end
      alias_method :inspect, :to_s

      def save
        save_pair_name
        save_pair_email
      end

      private

      def base_email
        wrapper.config("git-duo.email").first ||
          guess_base_email_from_authors ||
          raise(Git::Duo::EmailNotImplementedError)
      end

      def guess_base_email_from_authors
        domains = authors.map {|author|
          author.email.split(?@).last
        }.uniq

        "dev+%names@#{domains.first}" if domains.size == 1
      end

      def save_pair_name
        wrapper.config "user.name '#{name}'"
      end

      def save_pair_email
        wrapper.config "user.email '#{email}'"
      end
    end
  end
end
