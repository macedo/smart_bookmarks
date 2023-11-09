require "rails_helper"

RSpec.describe "POST /api/v1/bookmarks", type: :request do
  context "authenticated user" do
    let(:api_key) { create(:api_key, :for_user) }
    let(:headers) {
      {
        "Authorization": "Bearer #{api_key.raw_token}",
      }
    }

    scenario "valid bookmark attributes" do
      attr = attributes_for(:bookmark)

      expect {
        post "/api/v1/bookmarks",
          params: { bookmark: attr },
          headers: headers
      }.to change(Bookmark, :count).by(1)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:link]).to eql attr[:link]
      expect(json[:name]).to eql attr[:name]
    end

    scenario "invalid bookmark attributes" do
      attr = attributes_for(:bookmark, name: "", link: "not-a-link")

      expect {
        post "/api/v1/bookmarks",
        params: { bookmark: attr },
        headers: headers
      }.to_not change(Bookmark, :count)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors][:link]).to eql(["must be a valid URI"])
      expect(json[:errors][:name]).to eql(["can't be blank"])
    end
  end

  context "unauthenticated user" do
    it "should return unauthorized error" do
      post "/api/v1/bookmarks"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eql ["Access denied"]
    end
  end
end
