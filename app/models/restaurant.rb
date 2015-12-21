class Restaurant < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, if: Proc.new { |a| a.address_changed? }

end
