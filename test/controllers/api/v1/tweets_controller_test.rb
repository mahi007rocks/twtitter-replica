require 'test_helper'

class Api::V1::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_tweets_index_url
    assert_response :success
  end

  test "should get follow_and_unfollow" do
    get api_v1_tweets_follow_and_unfollow_url
    assert_response :success
  end

end
