json.restaurants @restaurants do |restaurant|
  json.id restaurant.id
  json.name restaurant.name
  json.nameKana restaurant.name_kana
  json.link restaurant.link
  json.imageURL restaurant.image_url
  json.address restaurant.address
end
