require "rails_helper"

RSpec.describe ApiKey do
  describe "token digest generation" do
    subject(:api_key) { create(:api_key, :for_user) }

    it { expect(api_key.token_digest).not_to be_nil }

    it { expect(api_key.random_token_prefix).not_to be_nil }

    it { expect(api_key.common_token_prefix).not_to be_nil }
  end
end
