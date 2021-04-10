require 'test_helper'

class SentItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sent_items_index_url
    assert_response :success
  end

end
