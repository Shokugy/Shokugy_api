json.id @restaurant.id
json.name @restaurant.name
json.nameKana @restaurant.name_kana
json.link @restaurant.link
json.imageURL @restaurant.image_url
json.address @restaurant.address
if rate = Rate.find_by(restaurant_id: @restaurant.id, group_id: current_user.active_group_id)
  json.rate rate.rate
end

if @reviews.present?
  json.reviews @reviews do |review|
    json.restaurantId review.restaurant.id
    json.restaurantName review.restaurant.name
    json.restaurantNameKana review.restaurant.name_kana
    json.restaurantImageUrl review.restaurant.image_url
    json.restaurantAddress review.restaurant.address
    json.id review.id
    json.review review.review
    json.rate review.rate
  end
end
