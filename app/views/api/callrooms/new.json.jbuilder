if @callroom10.present?
  json.set! :callroom10 do
    json.id @callroom10.id
    json.title @callroom10.title
    json.student_id @callroom10.student_id
    json.body @callroom10.body
    json.status @callroom10.status
    json.user_name @callroom10.user.name
    json.user_imgage @callroom10.user.image_url
  end
end

if @callroom_now.present?
  json.set! :callroom_now do
    json.id @callroom_now.id
    json.title @callroom_now.title
    json.student_id @callroom_now.student_id
    json.body @callroom_now.body
    json.status @callroom_now.status
    json.user_name @callroom_now.user.name
    json.user_imgage @callroom_now.user.image_url
  end
end