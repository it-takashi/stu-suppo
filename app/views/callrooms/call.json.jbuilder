json.set! :student do
  json.id @student.id
  json.name @student.name
  json.introduction @student.introduction
  json.profile @student.profile
  json.image @student.image_url
  json.subject @student.subject
  json.rate @student.rate
end

json.set! :callroom do
  json.id @callroom.id
  json.title @callroom.title
  json.student_id @callroom.student_id
  json.body @callroom.body
  json.user_name @callroom.user.name
  json.user_imgage @callroom.user.image_url
end

if @already_callroom.present?
  json.set! :already_callroom do
    json.id @already_callroom.id
    json.user_name @already_callroom.user.name
  end
end