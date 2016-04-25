class CoursesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    render json: Course.all
  end

  def show
    render json: Course.find(params[:id])
  end

  def create
    course = Course.new(course_params)
    course.user = current_user
    if course.save
      render json: course, status: :created, location: course
    else
      render json: course.errors, status: :unprocessable_entity
    end 
  end

  def update
    course = Course.find(params[:id])
    if course.update(course_params)
      render json: course
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      render json: course
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:data)
          .require(:attributes).permit(:title)
  end
end
