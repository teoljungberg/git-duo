module Git
  module Duet
    class Author
      EMAIL_REGEXP = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i

      def self.import string
        key, *author = string.split
        new author.join(' '), key
      end

      attr_accessor :full, :key

      def initialize full, key
        @full = full
        @key = key
      end

      def name
        full.split[0..1].join ' '
      end

      def email
        full.scan(EMAIL_REGEXP).shift
      end

      def to_s
        "#{key} #{name} <#{email}>"
      end
    end
  end
end
