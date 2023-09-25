class ImagesController < ApplicationController
  before_action :set_post

  def new
    @image = @post.build_image
  end

  def create
    @image = @post.build_image(image_params)

    if @image.save
      redirect_to @post, notice: 'Image was successfully uploaded.'
    else
      render :new
    end
  end

  def edit
    @image = @post.image
  end

  def update
    @image = @post.image

    if @image.update(image_params)
      redirect_to @post, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def image_params
    params.require(:image).permit(:image_file)
  end
end
