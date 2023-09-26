class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings
  has_one_attached :image
  belongs_to :user

  def average_rating
    return 0 if ratings.empty?

    ratings_average = ratings.average(:value)
    ratings_average || 0
  end
end
