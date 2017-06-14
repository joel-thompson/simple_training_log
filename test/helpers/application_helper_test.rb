require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Logging Progress"
    assert_equal full_title("Sign Up"), "Sign Up | Logging Progress"
  end
end