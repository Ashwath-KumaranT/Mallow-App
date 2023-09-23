class PostsController < ApplicationController
  before_action :set_topic,  except: [:all_posts]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


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
    @posts = Post.page(params[:page]).per(2)
    # @posts = Post.all
  end

  def create
    @post = @topic.posts.new(post_params)
      if @post.save
       redirect_to topic_post_url(@topic, @post), notice: "Post was successfully created."
      else
          render :new, status: :unprocessable_entity, notice: "Post not saved"
      end
    end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
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
