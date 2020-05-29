json.user_name @reply.user.name
json.created_at @reply.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.comment @reply.comment
json.image @reply.image_url