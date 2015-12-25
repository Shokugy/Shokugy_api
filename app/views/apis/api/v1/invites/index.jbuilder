json.invites @invites do |invite|
  json.userFbId invite.user.fb_id
  json.userName invite.user.name
  json.restaurantId invite.restaurant.id
  json.restaurantName invite.restaurant.name
  json.restaurantAddress invite.restaurant.address
  json.id invite.id
  json.text invite.text
  json.pressTime invite.press_time
  json.date invite.created_at
  fb_ids = []
  invite.users.each do |user|
    fb_ids << user.fb_id
  end
  json.joinFbIds fb_ids
end
