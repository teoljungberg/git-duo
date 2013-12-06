require_relative '../../test_helper'

module Git::Duo
  class UserTest < MiniTest::Test
    def setup
      @user ||= User.new(user_options)
    end
    attr_reader :user

    def user_options
      {
        key: 'alfred',
        name: 'Alfred Pennyworth',
        email: 'alfred@gotham.travel'
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
      user = User.import("bruce Bruce Wayne <bruce@gotham.travel>")
      assert user.valid?
    end

    def test_user_to_s
      expected = "Alfred Pennyworth <alfred@gotham.travel>"
      assert_equal expected, user.to_s
    end
  end
end
