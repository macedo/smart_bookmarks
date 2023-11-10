require "rails_helper"

RSpec.describe "GET /bookmark/:id" do
  subject(:do_request) { get "/bookmarks/#{bookmark.id}" }

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

    it "render show template" do
      expect(response).to render_template(:show)
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
