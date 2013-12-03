require_relative '../../test_helper'

module Git::Duo
  class UserTest < MiniTest::Test
    def setup
      @user ||= User.new({ key: 'teo',
                           name: "Teo Ljungberg",
                           email: "teo.ljungberg@gmail.com" })
    end
    attr_reader :user

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
