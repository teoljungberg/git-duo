module Git
  module Duo
    class Author
      def self.import(new_author)
        key, first, last, email = extract_author new_author

        new({ key: key, name: "#{first} #{last}", email: email })
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

      private

      def self.extract_author new_author
        name, email = new_author.split(/^(.*) <(.*)>/)[1, 2]

        if name.split.size == 2
          key = name.split.first.downcase
          [key, name.split, email].flatten
        elsif name.split.size == 3
          [name.split, email].flatten
        end
      end
    end
  end
end
