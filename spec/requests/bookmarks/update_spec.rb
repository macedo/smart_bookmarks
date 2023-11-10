require "rails_helper"

RSpec.describe "PUT /bookmarks/:id" do
  subject(:do_request) { put "/bookmarks/#{bookmark.id}", params: params }

  let!(:user) { create(:user) }
  let!(:bookmark) { create(:bookmark, user: user) }

  context "with authenticated user" do
    before { sign_in user }

    context "with valid attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark)} }

      before { do_request }

      it "updates a bookmark" do
        bookmark.reload
        expect(bookmark.name).to eql params[:bookmark][:name]
      end

      it "redirect_to bookmarks index path" do
        expect(response).to redirect_to("/bookmarks")
      end

      it "show success updated message" do
        expect(flash[:notice]).to eql("Bookmark was successfully updated.")
      end
    end

    context "with invalid attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark, name: "", link: "https://john@doe.com")} }

      before { do_request }

      it "do not update bookmark" do
        expect(bookmark.link).not_to eql "https://john@doe"
      end

      it "have unprocessable_entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  context "without unauthenticated user" do
    let(:params) { {bookmark: {}} }

    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
