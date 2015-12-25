json.restaurants @restaurants do |restaurant|
  json.id restaurant.id
  json.name restaurant.name
  json.nameKana restaurant.name_kana
  json.link restaurant.link
  json.imageURL restaurant.image_url
  json.address restaurant.address
  rate = Rate.find_by(restaurant_id: restaurant.id, group_id: current_user.active_group_id)
  json.rate rate.rate
end
