class Auth::SessionsController < Devise::SessionsController
  respond_to :json
  before_filter :ensure_params_exist

  def create
    user_email = params[:user][:email].presence
    resource = user_email && User.find_by_email(user_email)

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      data = {
        data: {
          id: resource.id,
          type: 'user',
          attributes: {
            name: resource.name,
            email: resource.email,
            role: resource.role,
            authentication_token: resource.authentication_token
          }
        }
      }
      
      render json: data, status: 201
      return
    end
    invalid_login_attempt

  end

  protected
  def ensure_params_exist
    return unless params[:user][:email].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end