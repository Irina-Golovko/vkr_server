class ImagesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def create
    image = Image.new
    image.file = image_params[:file]
    image.document = Document.find(params[:document])
    if image.save
      render json: { url: "http://#{request.host_with_port}#{image.file.url}" }
    else
      render json: image.errors, status: :unprocessable_entity
    end 
  end

  private

  def image_params
    params.permit(:file)
  end
end
