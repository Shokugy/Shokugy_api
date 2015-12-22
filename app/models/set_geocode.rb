class SetGeocode

  @@restaurants = Restaurant.new

  def initialize
    @@restaurants = Restaurant.where(latitude: nil)
    set_geocode
  end

  def set_geocode
    @@restaurants.each do |restaurant|
      if restaurant.geocode
        restaurant.update(latitude: restaurant.geocode[0], longitude: restaurant.geocode[1])
      else
        postal_code = restaurant.postal_code
        latitude = GoogleGeocoding.instance.geocode_from(postal_code)[:latitude]
        longitude = GoogleGeocoding.instance.geocode_from(postal_code)[:longitude]
        restaurant.update(latitude: latitude, longitude: longitude)
      end
      sleep(1)
    end
  end

end
