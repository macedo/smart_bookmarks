module Api
  module V1
    class BookmarksController < BaseController
      def index
        bookmarks = current_user.bookmarks
        render json: {bookmarks: bookmarks}, status: :ok
      end

      def create
        bookmark = current_user.bookmarks.build(bookmark_params)

        if bookmark.save
          render json: bookmark, status: :created
        else
          json_response = {errors: bookmark.errors}
          render json: json_response, status: :unprocessable_entity
        end
      end

      private

      def bookmark_params = params.require(:bookmark).permit(:link, :name)
    end
  end
end
