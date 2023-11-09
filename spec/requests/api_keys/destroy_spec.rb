require "rails_helper"

RSpec.describe "DELETE /api_key/:id", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }
    let!(:api_key) { create(:api_key, bearer: user) }

    before { sign_in user }

    it "revokes user's api key" do
      expect {
        delete "/api_keys/#{api_key.id}"
      }.to_not change(ApiKey, :count)

      expect(response).to redirect_to("/api_keys")
      expect(flash[:notice]).to eql "API Key was successfully destroyed."
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      delete "/api_keys/1"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
