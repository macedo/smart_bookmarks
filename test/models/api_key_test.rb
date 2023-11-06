require "test_helper"

class ApiKeyTest < ActiveSupport::TestCase
  test "generate token_digest" do
    user = users(:macedo)
    api_key = ApiKey.create(bearer: user, name: "test")

    assert_not_nil api_key.token_digest
    assert_not_nil api_key.random_token_prefix
    assert_not_nil api_key.common_token_prefix
  end
end
