class Forecast < ApplicationRecord
  has_and_belongs_to_many :users

  attr_reader :city_and_country

  def w_data
    @data ||= JSON.parse(data)
  end

  def day_avg(period, type)
    type = type.to_s
    period.send(type + '_by') { |el| el['main']['temp_' + type].round }['main']['temp_' + type].round
  end

  def by_weekdays
    @weekdays_data ||= grouped_by_local_weekdays
  end

  def grouped_by_local_weekdays
    oh = ActiveSupport::OrderedHash.new
    w_data.each_with_object(oh) do |interval, memo|
      weekday = local_time_zone.utc_to_local(Time.at(interval['dt'])).strftime('%a')
      memo[weekday] ||= []
      memo[weekday] << interval
      memo
    end
  end

  def local_time_zone
    @timezone ||= Timezone[time_zone_name]
  end
end
