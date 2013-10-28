require 'git/duo/repo'

module Git
  module Duo
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
        join_authors authors
      end

      def pair_email
        email = repo.email.split(' ').pop
        insert_authors_into_email email
      end

      def set_pair_name
        repo.user_name = pair_name
      end

      def set_pair_email
        repo.user_email = pair_email
      end

      def insert_authors_into_email email
        email.
          split(?@).
          insert(1, ?+).
          insert(2, authors.map(&:key).sort.join(?+), ?@).
          join
      end

      def join_authors authors
        authors.map(&:name).join ' and '
      end

      def display_committer
        "#{pair_name} <#{pair_email}>"
      end

      def repo
        @repo ||= Repo.new Dir.pwd
      end
    end
  end
end
