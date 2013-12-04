require 'ostruct'

class Git::Duo::User < OpenStruct
  EMAIL_REGEXP = /(?:<?(.+@[^>]+)>?)/

  def self.import(new_user)
    key, *author = new_user.split(?\s)
    first, last, email = author

    new({ key: key,
          name: "#{first} #{last}",
          email: email.match(EMAIL_REGEXP)[1] })
  end

  def valid?
    key && name && email
  end

  def to_s
    "#{name} <#{email}>"
  end
end
