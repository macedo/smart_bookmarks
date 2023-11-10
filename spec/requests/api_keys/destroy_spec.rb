require "rails_helper"

RSpec.describe "DELETE /api_key/:id" do
  subject(:do_request) { delete "/api_keys/#{api_key.id}" }

  let!(:user) { create(:user) }
  let!(:api_key) { create(:api_key, bearer: user) }

  context "with authenticated user" do
    before { sign_in user }

    it "do not destroy an api key" do
      expect { do_request }.not_to change(ApiKey, :count)
    end

    it "revoke api_key" do
      do_request
      expect(api_key.reload.revoked_at).not_to be_nil
    end

    it "redirect_to api_key index path" do
      do_request
      expect(response).to redirect_to("/api_keys")
    end

    it "show success destroyed message" do
      do_request
      expect(flash[:notice]).to eql "API Key was successfully destroyed."
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
