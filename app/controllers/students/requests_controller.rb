class Students::RequestsController < ApplicationController
  before_action :authenticate_student!
  before_action :valid_account

  def create
    @request = Request.new(request_params)
        @request.university_id = current_student.university_id
        if @request.save
            render json: {
                status: 200,
                request: @request,
                toast: {header: 'Création Filière',
                    body: "Filière créée avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                errors: @request.errors.messages
            } 
        end
  end

  private
  def request_params
    params.require(:request).permit(:title, :description)
  end
  

  def valid_account
    unless current_student.valid_account
      flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
      redirect_to "/students/edit"
    end
  end
end
