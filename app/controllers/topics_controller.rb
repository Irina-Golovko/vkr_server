class TopicsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def index
    render json: Topic.all
  end

  def show
    render json: Topic.find(params[:id])
  end

  def create
    topic = Topic.new(topic_params)
    topic.user = current_user
    topic.course = Course.find(params[:data][:relationships][:course][:data][:id])
    if topic.save
      render json: topic, status: :created, location: topic
    else
      render json: topic.errors, status: :unprocessable_entity
    end 
  end

  def update
    topic = Topic.find(params[:id])
    if topic.update(topic_params)
      render json: topic
    else
      render json: topic.errors, status: :unprocessable_entity
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    if topic.destroy
      render json: topic
    else
      render json: topic.errors, status: :unprocessable_entity
    end
  end

  private

  def topic_params
    params.require(:data)
          .require(:attributes).permit(:title)
  end
end
