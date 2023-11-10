require "rails_helper"

RSpec.describe "POST /api_keys" do
  subject(:do_request) { post "/api_keys", params: params }

  let(:user) { create(:user) }

  context "with authenticated user" do
    before { sign_in user }

    context "with walid api key attributes" do
      let(:params) { {api_key: attributes_for(:api_key)} }

      it "creates new api key" do
        expect { do_request }.to change(ApiKey, :count).by(1)
      end

      it "redirect_to api_keys index path" do
        do_request
        expect(response).to redirect_to("/api_keys")
      end

      it "show success created message" do
        do_request
        expect(flash[:notice]).to eql "API Key was successfully created and <b>it will be displayed only now!!</b>"
      end
    end

    context "with invalid api key attributes" do
      let(:params) { {api_key: attributes_for(:api_key, name: "")} }

      it "do not create new api key" do
        expect { do_request }.not_to change(ApiKey, :count)
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
    let(:params) { {api_key: {}} }

    before { do_request }

    it { expect(response).to redirect_to("/users/sign_in") }
    it { expect(flash[:alert]).to eql "You need to sign in or sign up before continuing." }
  end
end
