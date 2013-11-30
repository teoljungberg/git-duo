require 'pry'

module Git
  module Duo
    class Wrapper
      def initialize(*args)
        @args = args
      end

      def config
        `git #{@args.join(' ')}`.split("\n")
      end
    end
  end
end
