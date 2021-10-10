class Universities::StudentsController < ApplicationController
  before_action :authenticate_university!
  before_action :valid_account
  def index
    @students = current_university.students.order(lastname: :asc)
    @fields = current_university.fields
  end

  def valid
    @student = Student.find(params[:id])
    valid_until= DateTime.now.next_year(1).to_time
    # render js:"console.log(#{@student}) "
    if @student.update({valid_account: true, valid_until: valid_until}) 
      @students = current_university.students.order(lastname: :asc)
      render json: {
        status: 200,
        toast: {color:"bg-success",
          body:"Compte de #{@student.lastname} #{@student.firstname} est validé jusqu'au #{valid_until}.",
          header: "Validation Etudiant"},
        students: @students
      }
    else  
      render json: {
        status: 500,
        toast: {color:"bg-danger",
          body:"Erreur lors de la viladation du compte de #{@student.lastname} #{@student.firstname}",
          header: "Validation Etudiant"}
      }
    end
  end

  def unvalid
    @student = params[:student]
    render json: {
      status: 200,
      message: "Message d'invalidation transmis à l'étudiant."
    }
  end

  def destroy
    @student = Student.find(params[:id])
    if @student.destroy
        render json: {
            status: 200,
            toast: {header: 'Suppression Etudiant',
                body: "Etudiant supprimer avec succès",
                color: "bg-success"}
        } 
    else
        render json: {
            status: 500,
            toast: {header: 'Suppression Etudiant',
                body: "Erreur lors de la suppression",
                color: "bg-danger"}
        } 
    end
  end

  def destroymail 
    raise
  end

  private
  def valid_account
      unless current_university.valid_account
          flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
          redirect_to "/universities/edit"
      end
  end
  
end
