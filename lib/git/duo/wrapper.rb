module Git
  module Duo
    class Wrapper
      def initialize(directory)
        @directory = directory
      end

      def config(args)
        `git --git-dir=#{@directory} #{__method__} #{args} 2>&1`.split("\n")
      end
    end
  end
end
