require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorials Sample App"
  end
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help Page | Ruby on Rails Tutorials Sample App"
  end
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About Page | Ruby on Rails Tutorials Sample App"
  end
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact Page | Ruby on Rails Tutorials Sample App"
  end
end
