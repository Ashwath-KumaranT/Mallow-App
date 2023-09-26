class PostsController < ApplicationController
  before_action :set_topic,  except: [:all_posts]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
      @topic = Topic.find(params[:topic_id])
      @posts = @topic.posts
  end


  def show
  end

  def new
    # @post = @topic.posts.new
    @post = @topic.posts.build
    @post.tag_ids = []

  end

  def all_posts
    # @posts = Post.page(params[:page]).per(2)
    @posts = Post.all
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    @post.image.attach(params[:post][:image]) if params[:post][:image]
      if @post.save
       redirect_to topic_post_url(@topic, @post), notice: "Post was successfully created."
      else
          render :new, status: :unprocessable_entity, notice: "Post not saved"
      end
    end

  def edit
    authorize! :update, @post
    @post = Post.find(params[:id])
  end

  def update
    authorize! :update, @post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    if @post.update(post_params)
      @post.image.attach(params[:post][:image]) if params[:post][:image]
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @post
    @post.destroy
    redirect_to topic_posts_path(@post.topic), notice: 'Post was successfully deleted.'
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:post_title, :post_content,  :topic_id, tag_ids: [])
  end

end
