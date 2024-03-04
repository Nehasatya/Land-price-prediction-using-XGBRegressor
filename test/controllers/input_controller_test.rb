require "test_helper"

class InputControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get input_index_url
    assert_response :success
  end

  test "should get new" do
    get input_new_url
    assert_response :success
  end

  test "should get info" do
    get input_create_url
    assert_response :success
  end
end
