# json.array! @topics, partial: "topics/topic", as: :topic
json.array! @topics do |topic|
  json.id topic.id
  json.title topic.name
  json.author topic.author
end