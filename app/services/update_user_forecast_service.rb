class UpdateUserForecastService
  def initialize(user)
    @user = user
  end

  def find_or_update
    @forecasts = @user.forecasts
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
