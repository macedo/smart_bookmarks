module Api
  class BaseController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :bad_request

    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :authenticate_with_api_key


    attr_reader :current_bearer, :current_api_key

    protected

    def authenticate_with_api_key
      authenticate_or_request_with_http_token do |token, opts|
        @current_api_key = ApiKey.find_by_token(token)
        @current_bearer = @current_api_key&.bearer
      end
    end

    def bad_request
      json_response = { errors: ["Bad request"] }
      render json: json_response, status: :bad_request
    end

    def request_http_token_authentication(realm="Application", message=nil)
      json_response = { errors: [message || "Access denied"] }
      headers["WWW-Authenticate"] = %(Bearer realm="#{realm.tr('"', "")}")
      render json: json_response, status: :unauthorized
    end
  end
end
