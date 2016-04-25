class Auth::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)
    if user.save(:validate => false)
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:data)
          .require(:attributes).permit(:name, :email, :role, :password)
  end
end