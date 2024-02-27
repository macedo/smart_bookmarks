require "rails_helper"

RSpec.describe "Bookmarks" do
  let!(:user) { create(:user) }
  let!(:bookmark) { create(:bookmark, user: user) }
  let!(:other_user_bookmark) { create(:bookmark) }

  before { sign_in user }

  describe "bookmarks management" do
    before { visit "/bookmarks" }

    describe "show correct data" do
      it { expect(page).to have_text(bookmark.name) }
      it { expect(page).to have_no_text(other_user_bookmark.name) }
    end
  end

  describe "create new bookmark" do
    before do
      visit "/bookmarks"
      click_on "New Bookmark"
      fill_in "Name", with: name
      fill_in "Link", with: "https://uol.com.br"
      click_on "Create Bookmark"
    end

    context "with valid attribute" do
      let(:name) { "uol" }

      it { expect(page).to have_text(name) }
      it { expect(page).to have_text("Bookmark was successfully created.") }
    end

    context "with invalid attribute" do
      let(:name) { "" }

      it { expect(page).to have_text("Name can't be blank") }
    end
  end

  describe "show bookmark info" do
    before do
      visit "/bookmarks"
      click_on bookmark.name
    end

    it { expect(page).to have_text(bookmark.name) }
  end

  describe "update bookmark name" do
    before do
      visit "/bookmarks"
      find("#bookmark_#{bookmark.id}").find_link("Edit").click
      fill_in "Name", with: name
      click_on "Update Bookmark"
    end

    context "with valid attribute" do
      let(:name) { "new bookmark name" }

      it { expect(page).to have_text(name) }
      it { expect(page).to have_no_text(bookmark.name) }
      it { expect(page).to have_text("Bookmark was successfully updated.") }
    end

    context "with invalid attribute" do
      let(:name) { "" }

      it { expect(page).to have_text("Name can't be blank") }
    end
  end

  describe "delete bookmark" do
    before do
      visit "/bookmarks"
      find("#bookmark_#{bookmark.id}").find_button("Delete").click
    end

    it { expect(page).to have_no_text(bookmark.name) }
  end
end
