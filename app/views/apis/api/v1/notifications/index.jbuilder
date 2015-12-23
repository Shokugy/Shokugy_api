json.notifications @notifications do |notification|
  json.content notification.content
  json.date notification.created_at
end
