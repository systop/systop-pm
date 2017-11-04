require 'test_helper'

class UpdatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @update = updates(:one)
  end

  test "should get index" do
    get updates_url
    assert_response :success
  end

  test "should get new" do
    get new_update_url
    assert_response :success
  end

  test "should create update" do
    assert_difference('Update.count') do
      post updates_url, params: { update: { body: @update.body, comment: @update.comment, task_id: @update.task_id, user_id: @update.user_id } }
    end

    assert_redirected_to update_url(Update.last)
  end

  test "should show update" do
    get update_url(@update)
    assert_response :success
  end

  test "should get edit" do
    get edit_update_url(@update)
    assert_response :success
  end

  test "should update update" do
    patch update_url(@update), params: { update: { body: @update.body, comment: @update.comment, task_id: @update.task_id, user_id: @update.user_id } }
    assert_redirected_to update_url(@update)
  end

  test "should destroy update" do
    assert_difference('Update.count', -1) do
      delete update_url(@update)
    end

    assert_redirected_to updates_url
  end
end
