class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings
  has_one_attached :image
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :posts_users_read_statuses
  has_many :readers, through: :posts_users_read_statuses, source: :user
  def marked_as_read?(user)
    readers.include?(user)
  end
  def mark_as_read(user)
    posts_users_read_statuses.find_or_create_by(user: user).update(read: true)
  end
  def average_rating
    return 0 if ratings.empty?

    ratings_average = ratings.average(:value)
    ratings_average || 0
  end

  # AjAX
  validates :post_title, length: {maximum: 20, message: 'Title should be lesser than 20 character'}
end
