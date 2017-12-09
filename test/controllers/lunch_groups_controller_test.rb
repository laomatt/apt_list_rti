require 'test_helper'

class LunchGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lunch_group = lunch_groups(:one)
  end

  test "should get index" do
    get lunch_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_lunch_group_url
    assert_response :success
  end

  test "should create lunch_group" do
    assert_difference('LunchGroup.count') do
      post lunch_groups_url, params: { lunch_group: {  } }
    end

    assert_redirected_to lunch_group_url(LunchGroup.last)
  end

  test "should show lunch_group" do
    get lunch_group_url(@lunch_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_lunch_group_url(@lunch_group)
    assert_response :success
  end

  test "should update lunch_group" do
    patch lunch_group_url(@lunch_group), params: { lunch_group: {  } }
    assert_redirected_to lunch_group_url(@lunch_group)
  end

  test "should destroy lunch_group" do
    assert_difference('LunchGroup.count', -1) do
      delete lunch_group_url(@lunch_group)
    end

    assert_redirected_to lunch_groups_url
  end
end
