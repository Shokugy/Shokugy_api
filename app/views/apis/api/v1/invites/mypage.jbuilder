json.invites @invites do |invite|
  json.restaurantName invite.restaurant.name
  json.restaurantAddress invite.restaurant.address
  json.id invite.id
  json.text invite.text
  json.date invite.created_at
  fb_ids = []
  invite.users.each do |user|
    fb_ids << user.fb_id
  end
  json.joinFbIds fb_ids
end
