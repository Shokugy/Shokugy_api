if @reviews
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
