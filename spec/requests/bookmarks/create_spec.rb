require "rails_helper"

RSpec.describe "POST /bookmarks" do
  subject(:do_request) { post "/bookmarks", params: params }

  let!(:user) { create(:user) }

  context "with authenticated user" do
    before { sign_in user }

    context "with valid attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark)} }

      it "creates new bookmark" do
        expect { do_request }.to change(Bookmark, :count).by(1)
      end

      it "redirect_to bookmarks index path" do
        do_request
        expect(response).to redirect_to("/bookmarks")
      end

      it "show success created message" do
        do_request
        expect(flash[:notice]).to eql "Bookmark was successfully created."
      end
    end

    context "with invalid attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark, name: "")} }

      it "do not create new bookmark" do
        expect { do_request }.not_to change(Bookmark, :count)
      end

      it "have unprocessable_entity status" do
        do_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render new template" do
        do_request
        expect(response).to render_template(:new)
      end
    end
  end

  context "with unauthenticated user" do
    let(:params) { {bookmark: {}} }

    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }

    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
