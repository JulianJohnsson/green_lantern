require 'test_helper'

class BridgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bridge = bridges(:one)
  end

  test "should get index" do
    get bridges_url
    assert_response :success
  end

  test "should get new" do
    get new_bridge_url
    assert_response :success
  end

  test "should create bridge" do
    assert_difference('Bridge.count') do
      post bridges_url, params: { bridge: { bank_connected: @bridge.bank_connected, expire_at: @bridge.expire_at, token: @bridge.token, user_id: @bridge.user_id } }
    end

    assert_redirected_to bridge_url(Bridge.last)
  end

  test "should show bridge" do
    get bridge_url(@bridge)
    assert_response :success
  end

  test "should get edit" do
    get edit_bridge_url(@bridge)
    assert_response :success
  end

  test "should update bridge" do
    patch bridge_url(@bridge), params: { bridge: { bank_connected: @bridge.bank_connected, expire_at: @bridge.expire_at, token: @bridge.token, user_id: @bridge.user_id } }
    assert_redirected_to bridge_url(@bridge)
  end

  test "should destroy bridge" do
    assert_difference('Bridge.count', -1) do
      delete bridge_url(@bridge)
    end

    assert_redirected_to bridges_url
  end
end
