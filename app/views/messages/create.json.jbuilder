json.user_name @message.user.name
json.user_id @message.user_id
json.user_image @message.user.image.url
json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.comment @message.comment
json.image @message.image_url
json.id @message.id