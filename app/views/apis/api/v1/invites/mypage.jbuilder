json.invites @invites do |invite|
  json.restaurantName invite.restaurant.name
  json.restaurantAddress invite.restaurant.address
  json.text invite.text
  json.date invite.created_at
  fb_ids = []
  invite.users.each do |user|
    fb_ids << user.fb_id
  end
  json.nakamaFbIds fb_ids
end