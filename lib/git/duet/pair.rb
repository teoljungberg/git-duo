require 'git/duet/wrapper'

module Git
  module Duet
    class Pair
      def initialize authors
        @authors = authors
      end

      def set
        set_pair_name
        set_pair_email
        display_committer
      end

      private
      attr_reader :authors

      def pair_name
        authors.
          map(&:name).
          join ' and '
      end

      def pair_email
        format = Wrapper.email_format
        format.split("@").
          insert(1, ?+).
          insert(2, authors.map(&:key).sort.join("+"), ?@).
          join
      end

      def set_pair_name
        Wrapper.user_name = pair_name
      end

      def set_pair_email
        Wrapper.user_email = pair_email
      end

      def display_committer
        "#{pair_name} <#{pair_email}>"
      end
    end
  end
end
