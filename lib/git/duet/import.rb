require 'git/duet/import'
require 'git/duet/wrapper'

module Git
  module Duet
    class Import
      NON_AUTHOR_REGEXP = /git-duet\.email/

      def initialize config
        @config = config
      end

      def email_pattern
        import_email_pattern
      end

      def authors
        import_authors
      end

      private
      attr_reader :config

      def import_authors
        extracted_authors.each do |string|
          author = Author.import string
          Wrapper.author = author
        end
      end

      def import_email_pattern
        email = config.select {|conf| conf.match NON_AUTHOR_REGEXP }.pop.split.pop
        Wrapper.email = email
      end

      def extracted_authors
        config.reject {|conf| conf.match NON_AUTHOR_REGEXP }.
          map {|author| author.split('git-duet.')[1..-1].shift }
      end
    end
  end
end
