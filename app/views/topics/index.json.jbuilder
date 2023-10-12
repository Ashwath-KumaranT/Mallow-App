# json.array! @topics, partial: "topics/topic", as: :topic
json.array! @topics do |topic|
  json.id topic.id
  json.title topic.title
  json.description topic.description
end