class Universities::FieldsController < ApplicationController
    before_action :authenticate_university!
    before_action :valid_account
    before_action :set_field, only: [:update, :destroy]
    def index
        @fields = current_university.fields
    end

    def create
        @field = Field.new(field_params)
        @field.university_id = current_university.id
        if @field.save
            render json: {
                status: 200,
                field: @field,
                toast: {header: 'Création Filière',
                    body: "Filière créée avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                errors: @field.errors.messages
            } 
        end
    end
    

    def update
        if @field.update(field_params)
            render json: {
                status: 200,
                message: {
                    text: "Filière modifiée avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                errors: @field.errors.messages
            } 
        end
    end

    def destroy
        @field = Field.find(params[:id])
        if @field.destroy
            render json: {
                status: 200,
                toast: {header: 'Suppression Filière',
                    body: "Filière supprimer avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                toast: {header: 'Suppression Filière',
                    body: "Erreur lors de la suppression",
                    color: "bg-danger"}
            } 
        end
    end
    

    private
    def set_field
        @field = Field.find(params[:id])
    end

    def field_params
        params.require(:field).permit(:name, :acronym)
    end

    def valid_account
        unless current_university.valid_account
            flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
            redirect_to "/universities/edit"
        end
    end
    
end
