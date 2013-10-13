require 'git/duet/repo'

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
        format = repo.email
        format.split(' ').pop.
          split('@').
          insert(1, ?+).
          insert(2, authors.map(&:key).sort.join('+'), ?@).
          join
      end

      %w(name email).each do |method|
        define_method("set_pair_#{method}") { eval "repo.user_#{method} = pair_#{method}" }
      end

      def display_committer
        "#{pair_name} <#{pair_email}>"
      end

      def repo
        @_repo = Repo.new Dir.pwd
      end
    end
  end
end
