json.set! :student do
  json.id @student.id
  json.name @student.name
  json.introduction @student.introduction
  json.profile @student.profile
  json.image @student.image_url
  json.subject @student.subject
  json.rate @student.rate
end

json.set! :current_user do
  json.id @current_user.id
  json.name @current_user.name
  json.introduction @current_user.introduction
  json.profile @current_user.profile
  json.image @current_user.image_url
  json.subject @current_user.subject
  json.rate @current_user.rate
end

json.set! :callroom do
  json.id @callroom.id
  json.title @callroom.title
  json.student_id @callroom.student_id
  json.body @callroom.body
  json.user_id @callroom.user.id
  json.user_name @callroom.user.name
  json.user_imgage @callroom.user.image_url
end