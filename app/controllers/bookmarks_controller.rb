class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]

  def index = @bookmarks = current_user.bookmarks.ordered

  def show
  end

  def new = @bookmark = Bookmark.new

  def edit
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)

    if @bookmark.save
      respond_to do |format|
        format.html { redirect_to bookmarks_path, notice: t(".notice") }
        format.turbo_stream { flash.now[:notice] = t(".notice") }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      respond_to do |format|
        format.html { redirect_to bookmarks_path, notice: t(".notice") }
        format.turbo_stream { flash.now[:notice] = t(".notice") }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_path, notice: t(".notice") }
      format.turbo_stream { flash.now[:notice] = t(".notice") }
    end
  end

  private

  def set_bookmark = @bookmark = current_user.bookmarks.find(params[:id])

  def bookmark_params = params.require(:bookmark).permit(:link, :name)
end
