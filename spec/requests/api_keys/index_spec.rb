require "rails_helper"

RSpec.describe "GET /api_keys" do
  subject(:do_request) { get "/api_keys" }

  let!(:user) { create(:user) }
  let!(:api_key) { create(:api_key, bearer: user) }

  context "with authenticated user" do
    before do
      sign_in user
      do_request
    end

    it "have http_status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "render index template" do
      expect(response).to render_template(:index)
    end

    it "assign user api keys" do
      expect(assigns(:api_keys)).to include(api_key)
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }
    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
