task "create_forecasts" => :environment do
  weather_api = OpenWeatherApi.new
  original =  {Tallin: 'EE', Tartu: 'EE', Brno: 'CZ'}
  original.each do |city, country|
    json = weather_api.weather(city: city, country: country)
    lat = json['city']['coord']['lat']
    lng = json['city']['coord']['lon']
    timezone = Timezone.lookup(lat, lng)
    forecast = Forecast.find_or_initialize_by(city_id: json['city']['id'])
    forecast.update_attributes(country_code: json['city']['country'], name: json['city']['name'], data: JSON.dump(json['list']), default_forecast: true,
                               lat: lat, lng: lng, time_zone_offset: timezone.utc_offset, time_zone_name: timezone.name)
  end
end
