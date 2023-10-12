# json.extract! @topic, :id, :title, :description, :created_at, :updated_at
# json.partial! "topics/topic", topic: @topic
json.id @topic.id
json.title @topic.title
json.author @topic.description