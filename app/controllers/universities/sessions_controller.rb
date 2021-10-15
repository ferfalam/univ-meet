# frozen_string_literal: true

class Universities::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @university = University.find_by(email: params[:session][:email])
    if @university.present?
      if @university.valid_password?(params[:session][:password])
        sign_in @university
        render json: {
          status: 200,
          url: '/universities/landing'
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
  #   params.require(:session).permit(:email, :password)
  # end
end
