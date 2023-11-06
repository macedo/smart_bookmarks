require "application_system_test_case"

class ApiKeysTest < ApplicationSystemTestCase
  setup do
    user = users(:macedo)
    @api_key = ApiKey.create(bearer: user, name: "local")
    @api_key_revoked = ApiKey.create(bearer: user, name: "local revoked", revoked_at: Time.now.utc)

    login_as user
  end

  test "creating a new api key" do
    visit api_keys_path
    assert_selector "h1", text: "API Keys"

    assert_no_text "local revoked"

    assert_text "local"
    assert_text @api_key.token_prefix

    click_on "New API Key"
    fill_in "Name", with: "chrome extension"

    click_on "Create API Key"

    assert_selector "h1", text: "API Keys"
    assert_text "chrome extension"
    # assert_selector ".api_key__name", text: "chrome extension"
    # assert_selector ".api_key__key", visible: true
  end

  test "revoke a api key" do
    visit api_keys_path
    assert_text @api_key.name

    click_on "Revoke", match: :first
    assert_no_text @api_key.name
   end
end
