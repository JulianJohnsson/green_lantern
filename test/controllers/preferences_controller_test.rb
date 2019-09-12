require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get preferences_new_url
    assert_response :success
  end

  test "should get create" do
    get preferences_create_url
    assert_response :success
  end

  test "should get update" do
    get preferences_update_url
    assert_response :success
  end

  test "should get destroy" do
    get preferences_destroy_url
    assert_response :success
  end

end
