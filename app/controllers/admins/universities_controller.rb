class Admins::UniversitiesController < ApplicationController
  before_action :authenticate_university!
  before_action :authorized?

  def index
    @universities = University.all.order(name: :asc)
  end

  def valid
    @university = University.find(params[:id])
    # render js:"console.log(#{@university}) "
    if @university.update({valid_account: true}) 
      @universities = University.all.order(name: :asc)
      render json: {
        status: 200,
        toast: {color:"bg-success",
          body:"Compte de #{@university.name} est validé",
          header: "Validation Université"},
        universities: @universities
      }
    else  
      render json: {
        status: 500,
        toast: {color:"bg-danger",
          body:"Erreur lors de la viladation du compte de #{@university.name}",
          header: "Validation Université"}
      }
    end
  end

  def unvalid
    @university = params[:university]
    render json: {
      status: 200,
      message: "Message d'invalidation transmis à l'étudiant."
    }
  end

  def destroy
    @university = University.find(params[:id])
    if @university.destroy
        render json: {
            status: 200,
            toast: {header: 'Suppression Université',
                body: "Université supprimer avec succès",
                color: "bg-success"}
        } 
    else
        render json: {
            status: 500,
            toast: {header: 'Suppression Université',
                body: "Erreur lors de la suppression",
                color: "bg-danger"}
        } 
    end
  end

  def destroymail 
    raise
  end
  
  private
  def authorized?
    unless current_university.admin
      redirect_to root_path
    end
  end
  
end
