class SetGeocode

  @@restaurants = Restaurant.new

  def initialize
    @@restaurants = Restaurant.all
    set_geocode
  end

  def set_geocode
    @@restaurants.each do |restaurant|
      restaurant.update(latitude: restaurant.geocode[0], longitude: restaurant.geocode[1])
      sleep(1)
    end
  end

end
