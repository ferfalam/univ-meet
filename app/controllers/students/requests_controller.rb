class Students::RequestsController < ApplicationController
  before_action :authenticate_student!
  before_action :valid_account
  
  def index
    @requests = current_student.requests.order(created_at: :desc)
  end
  

  def create
    @request = Request.new(request_params)
    @request.university_id = current_student.university_id
    @request.student_id = current_student.id
    if @request.save
        render json: {
            status: 200,
            requests: current_student.requests.order(created_at: :desc),
            toast: {header: 'Création Demande',
                body: "Demande créée avec succès",
                color: "bg-success"}
        } 
    else
        render json: {
            status: 500,
            errors: @request.errors.messages
        } 
    end
  end

  def destroy
        @request = Request.find(params[:id])
        if @request.destroy
            render json: {
                status: 200,
                toast: {header: 'Suppression Demande',
                    body: "Demande supprimer avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                toast: {header: 'Suppression Demande',
                    body: "Erreur lors de la suppression",
                    color: "bg-danger"}
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
