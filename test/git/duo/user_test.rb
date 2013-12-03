require_relative '../../test_helper'

module Git::Duo
  class UserTest < MiniTest::Test
    def setup
      @user ||= User.new({ key: 'teo',
                           name: "Teo Ljungberg",
                           email: "teo.ljungberg@gmail.com" })
    end
    attr_reader :user

    def user_options
      {
        key: 'teo',
        name: "Teo Ljungberg",
        email: "teo.ljungberg@gmail.com"
      }
    end

    def test_user_requires_name
      user = User.new user_options.merge(name: nil)
      refute user.valid?
    end

    def test_user_requires_email
      user = User.new user_options.merge(email: nil)
      refute user.valid?
    end

    def test_user_requires_key
      user = User.new user_options.merge(key: nil)
      refute user.valid?
    end

    def test_user_import
      user = User.import("billskog David Billskog <bilskog@gmail.com")
      assert user.valid?
    end

    def test_user_to_s
      expected = "teo Teo Ljungberg <teo.ljungberg@gmail.com>"
      assert_equal expected, user.to_s
    end
  end
end
