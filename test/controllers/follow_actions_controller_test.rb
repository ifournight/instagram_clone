require 'test_helper'

class FollowActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @follow_action = follow_actions(:one)
  end

  test "should get index" do
    get follow_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_follow_action_url
    assert_response :success
  end

  test "should create follow_action" do
    assert_difference('FollowAction.count') do
      post follow_actions_url, params: { follow_action: {  } }
    end

    assert_redirected_to follow_action_url(FollowAction.last)
  end

  test "should show follow_action" do
    get follow_action_url(@follow_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_follow_action_url(@follow_action)
    assert_response :success
  end

  test "should update follow_action" do
    patch follow_action_url(@follow_action), params: { follow_action: {  } }
    assert_redirected_to follow_action_url(@follow_action)
  end

  test "should destroy follow_action" do
    assert_difference('FollowAction.count', -1) do
      delete follow_action_url(@follow_action)
    end

    assert_redirected_to follow_actions_url
  end
end
