require "rails_helper"

RSpec.describe "GET /bookmarks/:id/edit", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }
    let!(:bookmark) { create(:bookmark, user: user) }

    before { sign_in user }

    it "returns http success" do
      get "/bookmarks/#{bookmark.id}/edit"

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
      expect(assigns(:bookmark)).to be_a(Bookmark)
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      get "/bookmarks/1/edit"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
