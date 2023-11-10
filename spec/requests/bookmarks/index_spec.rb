require "rails_helper"

RSpec.describe "GET /bookmarks" do
  subject(:do_request) { get "/bookmarks" }

  let!(:user) { create(:user) }
  let!(:bookmark) { create(:bookmark, user: user) }

  context "with authenticated user" do
    before do
      sign_in user
      do_request
    end

    it "have http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "render index template" do
      expect(response).to render_template(:index)
    end

    it "assign user bookmakrs" do
      expect(assigns(:bookmarks)).to include(bookmark)
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
