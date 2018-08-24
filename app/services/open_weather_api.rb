require 'uri'
require 'net/http'
require 'json'

class OpenWeatherApi
  # api.openweathermap.org/data/2.5/forecast?q={city name},{country code}

  def initialize(api_key = nil)
    @api_key = {APPID: api_key || ENV['WEATHER_API_KEY']}
  end

  def weather(options)
    return if options.empty?
    url = uri_params(options)
    response = send_request(url)
    parse_response(response)
  end

  class UnprocessableError < RuntimeError; end
  class ForbiddenError < RuntimeError; end
  class UnknownResponse < RuntimeError; end

private

  def uri_params(options)
    uri = URI(ENV['WEATHER_API_HOST'])
    uri.query = URI.encode_www_form(@api_key.merge(q: "#{options[:city]},#{options[:country]}", units: 'metric')) if options[:city] || options[:country]

    uri
  end

  def send_request(uri)
    req = Net::HTTP::Get.new(uri.request_uri)
    http_session = Net::HTTP.new(uri.hostname, uri.port)
    http_session.start { |http| http.request(req) }
  end

  def parse_response(response)
    return 'Something was wrong!' if response.nil?
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, 'Bad URI param!'
    else
      raise UnknownResponse, 'Something was wrong!'
    end
  end
end
