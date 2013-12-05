require 'git/duo/wrapper'

module Git::Duo
  class Pair
    attr_reader :users, :base_email

    def initialize(users, base_email, opts = {})
      @users = users.sort_by {|user| user.key }
      @base_email = base_email
      @wrapper = opts.fetch(:wrapper) { Git::Duo::Wrapper.new File.join(Dir.pwd, '.git') }
    end

    def name
      users.map(&:name).join ' + '
    end

    def email
      base_email.gsub "%names", users.map(&:key).join(?+)
    end

    def to_s
      "#{name} <#{email}>"
    end
    alias_method :inspect, :to_s

    def save
      !!(save_pair_name && save_pair_email)
    end

    private
    attr_reader :wrapper

    def save_pair_name
      wrapper.config "user.name '#{name}'"
    end

    def save_pair_email
      wrapper.config "user.email '#{email}'"
    end
  end
end
