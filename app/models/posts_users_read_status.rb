# app/models/posts_users_read_status.rb
class PostsUsersReadStatus < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
