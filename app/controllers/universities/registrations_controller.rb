# frozen_string_literal: true

class Universities::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    @university = University.new(configure_sign_up_params)
    if @university.save
      session[:university_id] = @university.id
      render json: {
        status: 200,
        url: new_university_session_path
      }
    else
      render json: {
        errors: @university.errors.messages
      }
    end
    
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    if params[:registration][:password]
      if current_university.valid_password?(params[:registration][:last_password])
        underUpdate
      else
        render json: {
          last_password_error: "Mot de passe incorrect"
        }
      end
    else
      underUpdate
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    params.require(:registration).permit(:name, :acronym, :phone_number, :email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def underUpdate
    if current_university.update(configure_sign_up_params)
      render json: {
        status: 200,
        user: current_university,
        message: "Vos informations ont été mis à jour"
      }
    else
      render json: {
        errors: current_university.errors.messages
      }
    end
  end
  
end
