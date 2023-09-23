class RatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.create(rating_params)
    redirect_to topic_post_path(@post.topic, @post)
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end