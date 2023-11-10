require "rails_helper"

RSpec.describe "POST /api/v1/bookmarks" do
  subject(:do_request) { post "/api/v1/bookmarks", params: params, headers: headers }

  let(:headers) {
    {
      "Authorization" => "Bearer #{api_key.raw_token}"
    }
  }

  context "with authenticated user" do
    let(:api_key) { create(:api_key, :for_user) }

    context "with valid bookmark attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark)} }

      it "creates new bookmark" do
        expect { do_request }.to change(Bookmark, :count).by(1)
      end

      it "have application/json content type" do
        do_request
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "have http status created" do
        do_request
        expect(response).to have_http_status(:created)
      end

      it "have correct response" do
        do_request
        expect(response.parsed_body[:link]).to eql params[:bookmark][:link]
      end
    end

    context "with invalid bookmark attributes" do
      let(:params) { {bookmark: attributes_for(:bookmark, name: "", link: "not-a-link")} }

      it "do not create bookmark" do
        expect { do_request }.not_to change(Bookmark, :count)
      end

      it "have application/json content type" do
        do_request
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "have http status unprocessable_entity" do
        do_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return validation error" do
        do_request
        expect(response.parsed_body[:errors][:link]).to eql(["must be a valid URI"])
      end
    end
  end

  context "with unauthenticated user" do
    let(:headers) { {} }
    let(:params) { {bookmark: {}} }

    before { do_request }

    it "have application/json content type" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "have http status unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end

    it "have corret error message" do
      expect(response.parsed_body[:errors]).to eql ["Access denied"]
    end
  end
end
