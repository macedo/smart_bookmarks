require "rails_helper"

RSpec.describe "ApiKeys" do
  let!(:user) { create(:user) }
  let!(:revoked_key) { create(:api_key, :revoked, bearer: user) }
  let!(:active_key) { create(:api_key, bearer: user) }
  let!(:other_user_key) { create(:api_key, :for_user) }

  before { sign_in user }

  describe "list user api keys list" do
    before { visit "/api_keys" }

    describe "show correct data" do
      it { expect(page).to have_text("API Keys") }
      it { expect(page).to have_text(active_key.name) }
      it { expect(page).not_to have_text(revoked_key.name) }
      it { expect(page).not_to have_text(other_user_key.name) }
    end
  end

  describe "creates new api key" do
    before do
      visit "/api_keys"
      click_link "New API Key"
      fill_in "Name", with: name
      click_button "Create API Key"
    end

    context "with valid attribute" do
      let(:name) { "chrome extension" }

      it { expect(page).to have_text("chrome extension") }
      it { expect(page).to have_text("API Key was successfully created and it will be displayed only now!!") }
    end

    context "with invalid attribute" do
      let(:name) { "" }

      it { expect(page).to have_text("Name can't be blank") }
    end
  end

  describe "revoke api key" do
    before do
      visit "/api_keys"
      find("#api_key_#{active_key.id}").find_button("Revoke").click
    end

    it { expect(page).not_to have_text(active_key.name) }
  end
end
