require 'test_helper'

class StatistiqueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statistique_index_url
    assert_response :success
  end

end
