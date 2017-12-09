require 'test_helper'

class LunchGroupUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lunch_group_user = lunch_group_users(:one)
  end

  test "should get index" do
    get lunch_group_users_url
    assert_response :success
  end

  test "should get new" do
    get new_lunch_group_user_url
    assert_response :success
  end

  test "should create lunch_group_user" do
    assert_difference('LunchGroupUser.count') do
      post lunch_group_users_url, params: { lunch_group_user: {  } }
    end

    assert_redirected_to lunch_group_user_url(LunchGroupUser.last)
  end

  test "should show lunch_group_user" do
    get lunch_group_user_url(@lunch_group_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_lunch_group_user_url(@lunch_group_user)
    assert_response :success
  end

  test "should update lunch_group_user" do
    patch lunch_group_user_url(@lunch_group_user), params: { lunch_group_user: {  } }
    assert_redirected_to lunch_group_user_url(@lunch_group_user)
  end

  test "should destroy lunch_group_user" do
    assert_difference('LunchGroupUser.count', -1) do
      delete lunch_group_user_url(@lunch_group_user)
    end

    assert_redirected_to lunch_group_users_url
  end
end
