class Restaurant < ActiveRecord::Base
  # geocoded_by :address
  # after_validation :geocode, if: Proc.new { |a| a.address_changed? }

  # association
  has_many :reviews, dependent: :delete_all
  has_many :invites, dependent: :delete_all
  has_many :rates, dependent: :delete_all
  has_many :favorites, dependent: :delete_all

  # scope
  scope :high_rates, ->(current_user){ where(group_id: current_user.active_group_id).order("rate DESC").limit(20) }
  scope :search_restaurants, ->(name){ where("name LIKE ? OR name_kana LIKE ?", "%#{name}%", "%#{name}%").limit(20) }

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
