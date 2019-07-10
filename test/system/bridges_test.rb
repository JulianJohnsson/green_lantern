require "application_system_test_case"

class BridgesTest < ApplicationSystemTestCase
  setup do
    @bridge = bridges(:one)
  end

  test "visiting the index" do
    visit bridges_url
    assert_selector "h1", text: "Bridges"
  end

  test "creating a Bridge" do
    visit bridges_url
    click_on "New Bridge"

    check "Bank connected" if @bridge.bank_connected
    fill_in "Expire at", with: @bridge.expire_at
    fill_in "Token", with: @bridge.token
    fill_in "User", with: @bridge.user_id
    click_on "Create Bridge"

    assert_text "Bridge was successfully created"
    click_on "Back"
  end

  test "updating a Bridge" do
    visit bridges_url
    click_on "Edit", match: :first

    check "Bank connected" if @bridge.bank_connected
    fill_in "Expire at", with: @bridge.expire_at
    fill_in "Token", with: @bridge.token
    fill_in "User", with: @bridge.user_id
    click_on "Update Bridge"

    assert_text "Bridge was successfully updated"
    click_on "Back"
  end

  test "destroying a Bridge" do
    visit bridges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bridge was successfully destroyed"
  end
end
