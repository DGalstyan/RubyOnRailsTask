class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token,
                     if: proc { |c| c.request.format == 'application/json' }
  def index
    @forecasts = UpdateForecastService.new.update_forecast
    respond_to do |format|
      format.html
      format.json
    end
  end
end
