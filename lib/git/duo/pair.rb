require 'git/duo/wrapper'
require 'pry'

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
        base_email.gsub "%names", authors.map(&:key).join(?+)
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
        wrapper.config("git-duo.email").shift
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
