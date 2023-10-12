class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]
  # load_and_authorize_resource

  def index
    @topics = Topic.all
    # @topic = Topic.all.includes(:user)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    # if @topic.save
    #   redirect_to topics_path, notice: 'Topic created successfully.'
    #   # respond_to format.json { render 'show' , status: :created }
    # else
    #   render :new
    # end
     respond_to do |format|
          if @topic.save
            redirect_to topics_path, notice: "Topic was successfully created."
            format.json { render 'show' , status: :created }
            #render json: @topic, status: :created
          else
            render json: @topic.errors, status: :unprocessable_entity
          end
    end
  end

  # def create
  #   @topic = Topic.new(topic_params)
  #
  #   respond_to do |format|
  #     if @topic.save
  #       format.html { redirect_to topic_url(@topic), notice: "Topic was successfully created." }
  #       format.json { render 'show' , status: :created }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @topic.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def show
    @topic = Topic.find(params[:id])
  end


  def edit
    authorize! :update, @topic
    @topic = Topic.find(params[:id])
  end

  # def update
  #   authorize! :update, @topic
  #   if @topic.update(topic_params)
  #     redirect_to topics_path, notice: 'Topic updated successfully.'
  #   else
  #     render :edit
  #   end
  # end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: "Topic #{@topic.title} was successfully updated." }
        format.json { render 'show' , status: :created }
        #render json: @topic, status: :ok
      else
        format.html { render :edit, status: :unprocessable_entity }
        # render json: @topic.errors, status: :unprocessable_entity
      end
end
end


  def destroy
    # authorize! :destroy, @topic
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
      format.json{ }
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end



# class TopicsController < ApplicationController
#   before_action :set_topic, only: %i[ show edit update destroy ]
#
#   # GET /topics or /topics.json
#   def index
#     @topics = Topic.all
#     #render json: @topics
#   end
#   def all_posts
#     @topics = Topic.all
#     @posts = Post.all
#     @post = @posts.first
#     @comments = Comment.where(post_id: @post.id)
#     @tags =Tag.where(post_id: @post.id)
#     # @comments =Comment.where(post_id: @posts.pluck(:id))
#   end
#   # GET /topics/1 or /topics/1.json
#   def show
#     @topic = Topic.find(params[:id])
#     #render json: @topic
#     # @posts = @topic.posts
#   end
#
#   # GET /topics/new
#   def new
#     @topic = Topic.new
#   end
#
#   # GET /topics/1/edit
#   def edit
#   end
#
#   # POST /topics or /topics.json
#   def create
#     @topic = Topic.new(topic_params)
#
#     respond_to do |format|
#       if @topic.save
#         format.html { redirect_to topic_url(@topic), notice: "Topic was successfully created." }
#         format.json { render json: @topic, status: :created }
#       else
#         format.html { render :new }
#         format.json { render json: @topic.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /topics/1 or /topics/1.json
#   def update
#     respond_to do |format|
#       if @topic.update(topic_params)
#         format.html { redirect_to topic_url(@topic), notice: "Topic #{@topic.title} was successfully updated." }
#         format.json { render 'show' , status: :created }
#         #render json: @topic, status: :ok
#
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         # render json: @topic.errors, status: :unprocessable_entity
#
#       end
#     end
#   end
#
#   # DELETE /topics/1 or /topics/1.json
#   def destroy
#     @topic.destroy
#     respond_to do |format|
#       format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
#       format.json
#     end
#     #render json: { head: :no_content}
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_topic
#     @topic = Topic.find(params[:id])
#   end
#
#   # Only allow a list of trusted parameters through.
#   def topic_params
#     params.require(:topic).permit(:title,:description)
# end
# end
