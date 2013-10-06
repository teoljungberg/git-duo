module Git
  module Duet
    class Wrapper
      class << self
        def author key
          config "git-duet.#{key}"
        end

        def current_committer
          "#{user_name} <#{user_email}>"
        end

        def unpair!
          config '--remove-section user'
          current_committer
        end

        def email_format
          config 'git-duet.email-format'
        end

        def email_format= format
          config "git-duet.email-format '#{format}'"
        end

        def user_email
          config "user.email"
        end

        def user_email= email
          config "user.email '#{email}'"
        end

        def user_name
          config "user.name"
        end

        def user_name= name
          config "user.name '#{name}'"
        end

        private

        def config arg
          `git config #{arg}`.strip
        end
      end
    end
  end
end
