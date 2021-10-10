class Universities::RequestsController < ApplicationController
    before_action :authenticate_university!
    before_action :valid_account
    before_action :set_request, only: [:destroy]
    def index
        @requests = current_university.requests
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
    def set_request
        @request = Request.find(params[:id])
    end

    def valid_account
        unless current_university.valid_account
            flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
            redirect_to "/universities/edit"
        end
    end
end
