require "application_system_test_case"

class BookmarksTest < ApplicationSystemTestCase
  setup do
    login_as users(:macedo)
    @bookmark = Bookmark.ordered.first
  end

  test "creating new bookmark" do
    visit bookmarks_path
    assert_selector "h1", text: "Bookmarks"

    click_on "New Bookmark"
    fill_in "Name", with: "Rails Guides"
    fill_in "Link", with: "https://guides.rubyonrails.org"

    assert_selector "h1", text: "Bookmarks"
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
    fill_in "Name", with: "Updated bookmark name"

    assert_selector "h1", text: "Bookmarks"
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
