class ApiKeysController < ApplicationController
  before_action :set_api_key, only: %i[destroy]

  def index = @api_keys = current_user.api_keys.active

  def new = @api_key = ApiKey.new

  def create
    @api_key = current_user.api_keys.create(api_key_params)

    if @api_key.save
      respond_to do |format|
        format.html { redirect_to api_keys_path, notice: t(".notice") }
        format.turbo_stream { flash.now[:notice] = t(".notice") }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @api_key.update!(revoked_at: Time.now.utc)

    respond_to do |format|
      format.html { redirect_to api_keys_path, notice: t(".notice") }
      format.turbo_stream { flash.now[:notice] = t(".notice") }
    end
  end

  private

  def set_api_key = @api_key = current_user.api_keys.find(params[:id])

  def api_key_params = params.require(:api_key).permit(:name)
end
