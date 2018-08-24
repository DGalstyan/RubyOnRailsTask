class ForecastService
  def initialize(attrs, user)
    @city = attrs[:name]
    @user = user
    @country = attrs[:country_code]
    @country_code = ISO3166::Country.find_country_by_name(@country)
    @lat = attrs[:lat]
    @lng = attrs[:lng]
  end

  def create_forecast
    return 'City is not found' unless @city.present?
    weather_api = OpenWeatherApi.new
    json = weather_api.weather(city: @city, country: @country_code)

    city_id = json['city']['id']
    user_forecast = @user.forecasts.find_by(city_id: city_id)

    if user_forecast.present?
      user_forecast.update_attributes(data: JSON.dump(json['list']))
    else
      user_forecast = Forecast.find_by(city_id: city_id)
      if user_forecast.present?
        ForecastsUser.create(user_id: @user.id, forecast_id: user_forecast.id)
      else
        timezone = Timezone.lookup(@lat, @lng)
        @user.forecasts.create(city_id: city_id,
                               country_code: json['city']['country'],
                               name: json['city']['name'],
                               data: JSON.dump(json['list']),
                               lat: @lat, lng: @lng,
                               time_zone_offset: timezone.utc_offset,
                               time_zone_name: timezone.name)
      end
    end
    'The Forecast has been added'
  end
end
