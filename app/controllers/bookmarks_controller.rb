class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i(show edit update destroy)

  def index = @bookmarks = Bookmark.all

  def show; end

  def new = @bookmark = Bookmark.new

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to bookmarks_path, notice: "Bookmark was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to bookmarks_path, notice: "Bookmark was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path, notice: "Bookmark was successfully destroyed."
  end

  private

  def set_bookmark = @bookmark = Bookmark.find(params[:id])

  def bookmark_params = params.require(:bookmark).permit(:link, :name)
end
