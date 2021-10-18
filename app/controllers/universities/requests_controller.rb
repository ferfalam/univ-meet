class Universities::RequestsController < ApplicationController
    before_action :authenticate_university!
    before_action :valid_account
    before_action :set_request, only: [:destroy]
    def index
        @requests = current_university.requests.order(created_at: :desc)
    end


    def approve
        @request = Request.find(params[:id])
        if @request.update({approve: true})
            render json: {
                status: 200,
                requests:  current_university.requests.order(created_at: :desc),
                toast: {header: 'Approuvé demande',
                    body: "Demande approuvée avec succès",
                    color: "bg-success"}
            }
        else
            render json: {
                status: 500,
                toast: {header: 'Approuvé demande',
                    body: "Erreur lors de l'action",
                    color: "bg-danger"}
            }
        end
    end

    def rejet
        @request = Request.find(params[:id])    
        if @request.update({rejet: true})
            render json: {
                status: 200,
                requests:  current_university.requests.order(created_at: :desc),
                toast: {header: 'Rejet demande',
                    body: "Demande rejetée avec succès",
                    color: "bg-success"}
            }
        else
            render json: {
                status: 500,
                toast: {header: 'Rejet demande',
                    body: "Erreur lors de l'action",
                    color: "bg-danger"}
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
