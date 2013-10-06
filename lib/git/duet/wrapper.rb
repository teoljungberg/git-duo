module Git
  module Duet
    class Wrapper
      class << self
        %w(user_email user_name).each do |method|
          define_method(method) { config "#{method.gsub(?_, ?.)}" }
          define_method(method + ?=) { |new_value| config "#{method.gsub(?_, ?.)} '#{new_value}'" }
        end

        %w(email).each do |method|
          define_method(method) { config "git-duet.#{method}" }
          define_method(method + ?=) { |new_value| config "git-duet.#{method} '#{new_value}'" }
        end

        def current_committer
          "#{user_name} <#{user_email}>"
        end

        def unpair!
          config '--remove-section user'
          current_committer
        end

        def author key
          config "git-duet.#{key}"
        end

        def author= args
          config "git-duet.#{args.first} '#{args.last}'"
        end

        private

        def config arg
          `git config #{arg}`.strip
        end
      end
    end
  end
end
