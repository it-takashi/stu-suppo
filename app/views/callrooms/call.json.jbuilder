json.set! :student do
  json.id @student.id
  json.name @student.name
  json.introduction @student.introduction
  json.profile @student.profile
  json.image @student.image_url
  json.subject @student.subject
  json.rate @student.image_url
end

json.set! :callroom do
  json.id @callroom.id
end