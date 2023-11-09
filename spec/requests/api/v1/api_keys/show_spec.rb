require "rails_helper"

RSpec.describe "GET /api/v1/api_key", type: :request do
  context "authenticated user" do
    let(:api_key) { create(:api_key, :for_user) }
    let(:headers) {
      {
        "Authorization": "Bearer #{api_key.raw_token}",
      }
    }

    it "returns http success" do
      get "/api/v1/api_key", headers: headers

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)


      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:bearer_type]).to eql api_key.bearer_type
      expect(json[:bearer_id]).to eql api_key.bearer_id
    end
  end

  context "unauthenticated user" do
    it "should return unauthorized error" do
      get "/api/v1/api_key"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eql ["Access denied"]
    end
  end
end
