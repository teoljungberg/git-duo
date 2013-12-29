module Git
  module Duo
    class Author
      EMAIL_REGEXP = /(?:<?(.+@[^>]+)>?)/

      def self.import(new_author)
        key, *author = new_author.split(?\s)
        first, last, email = author

        new({ key: key,
              name: "#{first} #{last}",
              email: email.match(EMAIL_REGEXP)[1] })
      end

      attr_reader :key, :name, :email

      def initialize(opts = {})
        @key = opts[:key]
        @name = opts[:name]
        @email = opts[:email]
      end

      def valid?
        key && name && email
      end

      def to_s
        "#{name} <#{email}>"
      end
    end
  end
end
