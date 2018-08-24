class ForecastsController < ApplicationController
  load_and_authorize_resource :forecast, parent: false

  skip_before_action :verify_authenticity_token,
                     if: proc { |c| c.request.format == 'application/json' }

  def index
    @forecasts = UpdateUserForecastService.new(current_user).find_or_update
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show; end

  def new; end

  def create
    user_forecast = ForecastService.new(forecast_params, current_user).create_forecast
    respond_to do |format|
      format.html { redirect_to forecasts_path, notice: user_forecast }
      format.json
    end
  end

  def destroy
    @forecast.users.delete(current_user)
    respond_to do |format|
      format.html { redirect_to forecasts_path, notice: "The Forecast has been deleted" }
      format.json { head :no_content }
    end
  end

private

  def forecast_params
    params[:forecast].permit(:name, :country_code, :lat, :lng)
  end
end
