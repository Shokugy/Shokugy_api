require "csv"

CSV.foreach('db/restaurants.csv') do |row|
  Restaurant.create(id: row[0], name: row[1], name_kana: row[2], link: row[3], image_url: row[4], postal_code: row[5], address: row[6], latitude: row[9], longitude: row[10])
end
