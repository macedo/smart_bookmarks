require "rails_helper"

RSpec.describe "DELETE /bookmarks/:id", type: :request do
  context "authenticated user" do
    let!(:user) { create(:user) }
    let!(:bookmark) { create(:bookmark, user: user) }

    before { sign_in user }

    it "deletes user's bookmark" do
      expect {
        delete "/bookmarks/#{bookmark.id}"
      }.to change(Bookmark, :count).by(-1)

      expect(response).to redirect_to("/bookmarks")
      expect(flash[:notice]).to eql "Bookmark was successfully destroyed."
    end
  end

  context "unauthenticated user" do
    it "redirect_to sign in page" do
      delete "/bookmarks/1"

      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to eql "You need to sign in or sign up before continuing."
    end
  end
end
