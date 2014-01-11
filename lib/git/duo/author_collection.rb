module Git
  module Duo
    class AuthorCollection
      attr_reader :authors

      def initialize authors
        @authors = authors
      end

      def where opts = {}
        result = []
        result += opts.
          select {|k, _| authors.sample.respond_to? k }.
          map do |k, v|
            authors.select {|o| o.send(k) =~ /#{v}/i }
          end.flatten
      rescue NoMethodError
        result
      end
    end
  end
end
