require "application_system_test_case"

class BookmarksTest < ApplicationSystemTestCase
  setup do
    @bookmark= bookmarks(:first)
  end

  test "creating new bookmark" do
    visit bookmarks_path
    assert_selector "h1", text: "Bookmarks"

    click_on "New Bookmark"
    assert_selector "h1", text: "New Bookmark"

    fill_in "Name", with: "Rails Guides"
    fill_in "Link", with: "https://guides.rubyonrails.org"
    click_on "Create Bookmark"

    assert_selector "h1", text: "Bookmarks"
    assert_text "Rails Guides"
  end

  test "showing a bookmark" do
    visit bookmarks_path
    click_link @bookmark.name

    assert_selector "h1", text: @bookmark.name
  end

  test "updating a bookmark" do
    visit bookmarks_path
    assert_selector "h1", text: "Bookmarks"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit Bookmarks"

    fill_in "Name", with: "Updated bookmark name"
    click_on "Update Bookmark"

    assert_selector "h1", text: "Bookmarks"
    assert_text "Updated bookmark name"
  end

  test "destroying a bookmark" do
    visit bookmarks_path
    assert_text @bookmark.name

    click_on "Delete", match: :first
    assert_no_text @bookmark.name
  end
end
