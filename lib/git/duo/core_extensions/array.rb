module Git
  module Duo
    module CoreExtensions
      class ::Array
        def where(opts)
          opts.map do |k, v|
            self.select {|o| o.send(k) =~ /#{v}/i }
          end.flatten
        end
      end
    end
  end
end
