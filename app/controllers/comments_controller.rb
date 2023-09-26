# Comments Controller
class CommentsController < ApplicationController
  load_and_authorize_resource
  def index
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to topic_post_comments_path(@topic, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :update, @comment
    # @post = Post.find(params[:post_id])
    # @comment = Comment.find(params[:id])
  end
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :update, @comment
    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@topic, @post), notice: 'Comment was successfully updated.'
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end