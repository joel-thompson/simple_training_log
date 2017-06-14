require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	test "layout links" do
		get root_path
		assert_template "welcome/index"
  		assert_select "a[href=?]", root_path, count: 2
  		get signup_path
  		assert_select "title", full_title("Sign Up")
	end

end
