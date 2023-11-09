require "rails_helper"

RSpec.describe "POST /bookmarks", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }

    before { sign_in user }

    scenario "valid bookmark attributes" do
      attr = attributes_for(:bookmark)

      expect {
        post "/bookmarks",
        params: { bookmark: attr }
      }.to change(Bookmark, :count).by(1)

      expect(response).to redirect_to("/bookmarks")
      expect(flash[:notice]).to eql "Bookmark was successfully created."
    end

    scenario "invalid bookmark attributes" do
      attr = attributes_for(:bookmark, name: "")

      expect {
        post "/bookmarks",
        params: { bookmark: attr }
      }.to_not change(Bookmark, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
      expect(assigns(:bookmark)).to be_a(Bookmark)
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      post "/bookmarks"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
