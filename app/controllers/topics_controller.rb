class TopicsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_topic, only: [:edit, :update, :destroy]
  # load_and_authorize_resource

  def index
    @topics = Topic.all
    # @topic = Topic.all.includes(:user)
    # render json: @topics
    # render 'index.json.jbuilder'
  end


  def new
    @topic = Topic.new
  end

  # def create
  #   @topic = Topic.new(topic_params)
  #   @topic.user_id = 1
  #   if @topic.save
  #     redirect_to topics_path, notice: 'Topic created successfully.'
  #     format.json { render json: @topic, status: :created, location: @topic }
  #     # render json: @topic, status: :created
  #   else
  #     render :new
  #     # render json: { error: "Error creating title" }, status: :unprocessable_entity
  #   end
  # end
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { render 'show', status: :created }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end



  def show
    @topic = Topic.find(params[:id])
    # render json: @topic
    # render 'show.json.jbuilder'
  end


  def edit
    # authorize! :update, @topic
    @topic = Topic.find(params[:id])
  end

  # def update
  #   authorize! :update, @topic
  #   if @topic.update(topic_params)
  #     redirect_to topics_path, notice: 'Topic updated successfully.'
  #   else
  #     render :edit
  #   end
  #   # if @topic.update(topic_params)
  #   #   render json: @topic, status: :ok
  #   # else
  #   #   render json: @topic.errors, status: :unprocessable_entity
  #   # end
  # end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_path, notice: "Topic #{@topic.title} was successfully updated." }
        format.json { render 'show', status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   # authorize! :destroy, @topic
  #   @topic.destroy
  #   respond_to do |format|
  #     format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
  #   end
  #   # render json: { head: :no_content }
  # end
  def destroy
    authorize! :destroy, @topic
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description, :user_id)
  end

end
