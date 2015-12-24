json.groups @groups do |group|
  binding.pry
  json.groupId group.id
  json.groupName group.name
end
