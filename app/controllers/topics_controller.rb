class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
  end


  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path, notice: 'Topic created successfully.'
    else
      render :new
    end
  end

  def show
    # @topic = Topic.find(params[:id])
  end


  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: 'Topic updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    head :no_content
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
