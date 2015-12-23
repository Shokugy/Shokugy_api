class Restaurant < ActiveRecord::Base
  # geocoded_by :address
  # after_validation :geocode, if: Proc.new { |a| a.address_changed? }

  # association
  has_many :reviews
  has_many :invites
  has_many :rates

  class << self
    def set_geocode(restaurants)
      restaurants.each do |restaurant|
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

end
