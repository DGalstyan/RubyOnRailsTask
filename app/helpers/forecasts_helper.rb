module ForecastsHelper
  def w_icon(code, icon_code)
    daytime = icon_code[-1] == 'n' ? 'night' : 'day'
    "wi-owm-#{daytime}-#{code}"
  end

  def w_main(data)
    data['main']
  end

  def w_weather(data)
    data['weather'][0]
  end

  def w_clouds(data)
    data['clouds']
  end

  def w_wind(data)
    data['wind']
  end

  def w_rain(data)
    data['rain']
  end

  def w_snow(data)
    data['rain']
  end

  def w_dt_txt(data)
    data['rain']
  end

  def precipitation(data)
    rain = data['rain']
    snow = data['snow']
    rain = rain.present? ? rain['3h'] : 0
    snow = snow.present? ? snow['3h'] : 0
    (rain + snow) * 1_000
  end

  def local_time(name)
    Timezone[name].utc_to_local(Time.now.utc).strftime('%A %l:%M %p')
  end
end
