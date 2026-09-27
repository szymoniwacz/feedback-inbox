require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  test "home page responds" do
    get root_path
    assert_response :success
    assert_match "Feedback Inbox", response.body
  end
end
