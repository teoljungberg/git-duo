module Git::Duo
  class Pair
    attr_reader :users, :base_email

    def initialize(users, base_email)
      @users = users.sort_by {|user| user.key }
      @base_email = base_email
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
  end
end
