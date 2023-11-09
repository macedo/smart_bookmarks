require "rails_helper"

RSpec.describe ApiKey do
  let(:user) { create :user }

  it "generates token digest" do
    api_key = create(:api_key, bearer: user)

    expect(api_key.token_digest).to_not be_nil
    expect(api_key.random_token_prefix).to_not be_nil
    expect(api_key.common_token_prefix).to_not be_nil
  end
end
