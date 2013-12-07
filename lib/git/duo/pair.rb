require 'git/duo/wrapper'

module Git
  module Duo
    class Pair
      def self.destroy
        wrapper.config '--remove-section user'
      end

      def self.committer
        wrapper.config '--get user.name'
      end

      attr_reader :authors, :base_email, :wrapper

      def initialize(authors, base_email, opts = {})
        @authors = authors.sort_by {|author| author.key }
        @base_email = base_email
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

      def save_pair_name
        wrapper.config "user.name '#{name}'"
      end

      def save_pair_email
        wrapper.config "user.email '#{email}'"
      end

      def self.wrapper
        Wrapper.new File.join(Dir.pwd, '.git')
      end
    end
  end
end
