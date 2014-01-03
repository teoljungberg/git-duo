module Git
  module Duo
    class AuthorCollection < Struct.new(:authors)
      def where(opts)
        result = []
        result += opts.
          select {|k, _| authors.sample.respond_to? k }.
          each do |k, v|
            authors.select {|o| o.send(k) =~ /#{v}/i }
          end.flatten
      rescue NoMethodError
        result
      end
    end
  end
end
