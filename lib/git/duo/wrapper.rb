module Git
  module Duo
    class Wrapper
      PIPE_STDOUT_TO_STDERR = '2>&1'

      def self.top_level
        directory = `git rev-parse --show-toplevel #{PIPE_STDOUT_TO_STDERR}`.strip
        raise NotAGitRepository unless $?.exitstatus.zero?
        directory
      end

      def initialize(directory)
        @directory = directory
      end

      def config(args)
        `git --git-dir=#{@directory} config #{args} #{PIPE_STDOUT_TO_STDERR}`.split("\n")
      end
    end
  end
end
