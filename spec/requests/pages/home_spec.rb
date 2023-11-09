require "rails_helper"

RSpec.describe "GET home", type: :request do
  it "returns http success" do
    get "/"

    expect(response).to have_http_status(:ok)
    expect(response).to render_template(:home)
  end
end
