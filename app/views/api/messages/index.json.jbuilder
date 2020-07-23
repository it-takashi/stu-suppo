json.array! @messages do |message|
  json.comment message.comment
  json.image message.image.url
  json.user_id message.user_id
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.user_image message.user.image.url
  json.id message.id  
end