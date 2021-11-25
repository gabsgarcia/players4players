require 'test_helper'

class GamesSessionListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get games_session_lists_index_url
    assert_response :success
  end

  test "should get available" do
    get games_session_lists_available_url
    assert_response :success
  end

end
