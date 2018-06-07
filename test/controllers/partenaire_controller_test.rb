require 'test_helper'

class PartenaireControllerTest < ActionDispatch::IntegrationTest
  test "should get sponsor" do
    get partenaire_sponsor_url
    assert_response :success
  end

end
