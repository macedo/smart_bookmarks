require "rails_helper"

RSpec.describe "GET /bookmarks/new" do
  subject(:do_request) { get "/bookmarks/new" }

  let!(:user) { create(:user) }

  context "with authenticated user" do
    before do
      sign_in user
      do_request
    end

    it "have http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "render new template" do
      expect(response).to render_template(:new)
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }
    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
