require 'test_helper'

class RankControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rank_index_url
    assert_response :success
  end

end
