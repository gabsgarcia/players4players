require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get available" do
    get index_available_url
    assert_response :success
  end

end
