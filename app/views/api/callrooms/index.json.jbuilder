if @student.present?
  json.set! :student do
    json.id @student.id
    json.name @student.name
    json.introduction @student.introduction
    json.image @student.image_url
    json.subject @student.subject
    json.rate @student.rate
  end
end

if @callroom.present?
  json.set! :callroom do
    json.id @callroom.id
    json.title @callroom.title
    json.student_id @callroom.student_id
    json.body @callroom.body
    json.status @callroom.status
    json.user_name @callroom.user.name
    json.user_imgage @callroom.user.image_url
  end
end