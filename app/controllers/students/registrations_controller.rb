# frozen_string_literal: true

class Students::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @universities = University.all 
    @fields = Field.all 
  end

  # POST /resource
  def create
    @student = Student.new(configure_sign_up_params)
    @student.valid_until = DateTime.now
    if @student.save
      session[:student_id] = @student.id
      render json: {
        status: 200,
        url: new_student_session_path
      }
    else
      render json: {
        errors: @student.errors.messages
      }
    end
  end

  # GET /resource/edit
  def edit
    @user_info = {
      university: current_student.university,
      field: current_student.field
    }
  end

  # PUT /resource
  def update
    if params[:registration][:password]
      if current_student.valid_password?(params[:registration][:last_password])
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
  # def destroy
  #   super
  # end

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
    params.require(:registration).permit(:firstname, :lastname, :email, :phone_number, :personal_number, :password, :password_confirmation, :field_id, :university_id, :card_image)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    params.require(:registration).permit(:email, :phone_number, :password, :password_confirmation,)
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
    if current_student.update(configure_account_update_params)
      render json: {
        status: 200,
        user: current_student,
        message: "Vos informations ont été mis à jour"
      }
    else
      render json: {
        errors: current_student.errors.messages
      }
    end
  end
end
