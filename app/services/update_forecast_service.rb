class UpdateForecastService
  def update_forecast
    @forecasts = Forecast.where(default_forecast: true)
    if @forecasts.first.present? && @forecasts.first.updated_at < 3.hours.ago
      weather_api = OpenWeatherApi.new
      @forecasts.each do |forecast|
        json = weather_api.weather(city: forecast.name, country: forecast.country_code)
        forecast.update_attributes(data: JSON.dump(json['list']))
      end
    end
    @forecasts
  end
end
