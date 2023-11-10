require "rails_helper"

RSpec.describe "DELETE /bookmarks/:id" do
  subject(:do_request) { delete "/bookmarks/#{bookmark.id}" }

  let!(:user) { create(:user) }
  let!(:bookmark) { create(:bookmark, user: user) }

  context "with authenticated user" do
    before { sign_in user }

    it "deletes a bookmark" do
      expect { do_request }.to change(Bookmark, :count).by(-1)
    end

    it "redirect_to bookmarks index path" do
      do_request
      expect(response).to redirect_to("/bookmarks")
    end

    it "show success destroyed message" do
      do_request
      expect(flash[:notice]).to eql "Bookmark was successfully destroyed."
    end
  end

  context "with unauthenticated user" do
    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
