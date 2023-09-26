class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @topics = Topic.all
    @topic = Topic.all.includes(:user)
  end


  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to topics_path, notice: 'Topic created successfully.'
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end


  def edit
    authorize! :update, @topic
    @topic = Topic.find(params[:id])
  end

  def update
    authorize! :update, @topic
    if @topic.update(topic_params)
      redirect_to topics_path, notice: 'Topic updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @topic
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
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
