module Git
  module Duet
    class Author
      EMAIL_REGEXP = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i

      attr_accessor :full, :key

      def initialize full, key
        @full = full
        @key = key
      end

      def name
        full.split[0..1].join ' '
      end

      def email
        full.scan(EMAIL_REGEXP).first
      end
    end
  end
end
