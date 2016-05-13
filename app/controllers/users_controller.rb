class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def index
    render json: User.all, each_serializer: UserWithoutTokenSerializer
  end

  def show
    render json: User.find(params[:id]), serializer: UserWithoutTokenSerializer
  end

  
end
