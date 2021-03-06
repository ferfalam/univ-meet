# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @student = Student.find_by(email: params[:session][:email])
    if @student.present?
      if @student.valid_password?(params[:session][:password])
        sign_in @student
        render json: {
          status: 200,
          url: '/students/landing'
        }
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
