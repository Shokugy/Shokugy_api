require 'pp'
require 'net/http'
require 'json'
require 'singleton'

class GoogleGeocoding
  include Singleton

  GEOCODER_BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"
  GOOGLE_API_KEY = "*****"

  # get geocodes from address by Google Maps Geocoding API
  def geocode_from(address)
    geocodes = {
      latitude:  nil,
      longitude: nil
    }
    encoded_address = URI.encode(address)
    url = request_url(encoded_address)
    uri = URI.parse(url)

    begin
      response = Net::HTTP.get_response(uri)
      # check response code
      case response
      when Net::HTTPSuccess then
        # 200 OK
        data = JSON.parse(response.body)
        latitude, longitude = get_coordinates(data)
        geocodes[:latitude]  = latitude
        geocodes[:longitude] = longitude
      else
        puts [uri.to_s, response.value].join(" : ")
      end
    rescue => e
      puts [uri.to_s, e.class, e].join(" : ")
    end

    geocodes
  end


  private

    def request_url(encoded_address)
      # when using API Key
      # "#{GEOCODER_BASE_URL}?address=#{encoded_address}&key=#{GOOGLE_API_KEY}&sensor=false"
      # when not using API Key
      "#{GEOCODER_BASE_URL}?address=#{encoded_address}&sensor=false"
    end

    def get_coordinates(data)
      coordinates = data['results'][0]['geometry']['location'] rescue nil
      if coordinates && coordinates.size == 2
        return [ (coordinates['lat'].to_f).round(8), (coordinates['lng'].to_f).round(8) ]
      end
      return [ nil, nil ]
    end
end
