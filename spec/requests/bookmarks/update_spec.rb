require "rails_helper"

RSpec.describe "PUT /bookmarks/:id", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }
    let!(:bookmark) { create(:bookmark, user: user) }

    before { sign_in user }

    scenario "valid bookmark attributes" do
      attr = attributes_for(:bookmark)

      put "/bookmarks/#{bookmark.id}", params: { bookmark: attr }

      expect(response).to redirect_to("/bookmarks")
      expect(flash[:notice]).to eql("Bookmark was successfully updated.")
    end

    scenario "invalid bookmark attributes" do
      attr = attributes_for(:bookmark, name: "")

      put "/bookmarks/#{bookmark.id}", params: { bookmark: attr }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
      expect(assigns(:bookmark)).to be_a(Bookmark)
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      put "/bookmarks/1"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
