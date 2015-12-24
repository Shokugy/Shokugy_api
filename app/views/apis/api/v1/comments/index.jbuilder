if @comments
  json.comments @comments do |comment|
    json.commentId comment.id
    json.text comment.text
    json.userId comment.user.id
    json.userFbId comment.user.fb_id
    json.userName comment.user.name
  end
end
