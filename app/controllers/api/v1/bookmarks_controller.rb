module Api
  module V1
    class BookmarksController < BaseController
      def create
        bookmark = current_bearer.bookmarks.build(bookmark_params)

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
