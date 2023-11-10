require "rails_helper"

RSpec.describe "GET /api/v1/api_key" do
  subject(:do_request) { get "/api/v1/api_key", headers: headers }

  let(:headers) {
    {
      "Authorization" => "Bearer #{api_key.raw_token}"
    }
  }

  context "with authenticated user" do
    let!(:api_key) { create(:api_key, :for_user) }

    before { do_request }

    it "have application/json content type" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "have http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "have correct response" do
      expect(response.parsed_body[:bearer_id]).to eql api_key.bearer_id
    end
  end

  context "with unauthenticated user" do
    let(:headers) { {} }

    before { do_request }

    it "have application/json content type" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "have http status unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end

    it "have correct error message" do
      expect(response.parsed_body[:errors]).to eql ["Access denied"]
    end
  end
end
