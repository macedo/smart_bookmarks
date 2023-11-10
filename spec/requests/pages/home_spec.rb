require "rails_helper"

RSpec.describe "pages#home" do
  describe "GET /" do
    before { get "/" }

    it { expect(response).to have_http_status(:ok) }

    it { expect(response).to render_template(:home) }
  end
end
