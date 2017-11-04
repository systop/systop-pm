require 'test_helper'

class AdminSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_setting = admin_settings(:one)
  end

  test "should get index" do
    get admin_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_setting_url
    assert_response :success
  end

  test "should create admin_setting" do
    assert_difference('AdminSetting.count') do
      post admin_settings_url, params: { admin_setting: { alias: @admin_setting.alias, description: @admin_setting.description, for: @admin_setting.for, title: @admin_setting.title, value: @admin_setting.value } }
    end

    assert_redirected_to admin_setting_url(AdminSetting.last)
  end

  test "should show admin_setting" do
    get admin_setting_url(@admin_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_setting_url(@admin_setting)
    assert_response :success
  end

  test "should update admin_setting" do
    patch admin_setting_url(@admin_setting), params: { admin_setting: { alias: @admin_setting.alias, description: @admin_setting.description, for: @admin_setting.for, title: @admin_setting.title, value: @admin_setting.value } }
    assert_redirected_to admin_setting_url(@admin_setting)
  end

  test "should destroy admin_setting" do
    assert_difference('AdminSetting.count', -1) do
      delete admin_setting_url(@admin_setting)
    end

    assert_redirected_to admin_settings_url
  end
end
