if @callroom.present?
  json.id @callroom.id
  json.title @callroom.title
  json.student_id @callroom.student_id
  json.body @callroom.body
  json.status @callroom.status
  json.user_name @callroom.user.name
  json.user_imgage @callroom.user.image_url
end