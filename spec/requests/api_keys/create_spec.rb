require "rails_helper"

RSpec.describe "POST /api_keys", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }

    before { sign_in user }

    scenario "valid api key attributes" do
      attr = attributes_for(:api_key)

      expect {
        post "/api_keys",
        params: { api_key: attr }
      }.to change(ApiKey, :count).by(1)

      expect(response).to redirect_to("/api_keys")
      expect(flash[:notice]).to eql "API Key was successfully created and <b>it will be displayed only now!!</b>"
    end

    scenario "invalid api key attributes" do
      attr = attributes_for(:api_key, name: "")

      expect {
        post "/api_keys",
        params: { api_key: attr }
      }.to_not change(ApiKey, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
      expect(assigns(:api_key)).to be_a(ApiKey)
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      post "/api_keys"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
