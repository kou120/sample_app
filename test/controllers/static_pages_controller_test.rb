require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  #Confirm that home page exists && check titile of home page
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end
  
  #Confirm that help page exists && check titile of help page
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end
  
  #Confirm that about page exists && check titile of about page
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end
  
  #Confirm that contact page exists && check titile of contact page
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
end