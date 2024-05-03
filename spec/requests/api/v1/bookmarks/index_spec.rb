require "rails_helper"

RSpec.describe "GET /api/v1/bookmarks" do
  subject(:do_request) { get "/api/v1/bookmarks", headers: headers }

  let(:headers) {
    {
      "Authorization" => "Bearer #{access_token.token}"
    }
  }

  context "with authenticated user" do
    let(:application) { create(:application) }
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, application: application, resource_owner_id: user.id) }
    let!(:bookmark) { create(:bookmark, user: user) }

    before { do_request }

    it "have application/json content type" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "have http status created" do
      expect(response).to have_http_status(:ok)
    end

    it "have correct response" do
      expect(response.parsed_body[:bookmarks][0][:id]).to eql bookmark.id
    end
  end

  context "with unauthenticated user" do
    let(:headers) {}

    before { do_request }

    it "have http status unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
