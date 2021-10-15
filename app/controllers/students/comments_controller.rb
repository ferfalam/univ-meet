class Students::CommentsController < ApplicationController
    before_action :authenticate_student!
    before_action :valid_account
    before_action :set_comment, only: [:destroy]

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render json: {
                status: 200,
                comment: @comment,
                toast: {header: 'Création Commentaire',
                    body: "Commentaire créé avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                errors: @comment.errors.messages
            } 
        end
    end

    def destroy
        if @comment.destroy
            render json: {
                status: 200,
                toast: {header: 'Suppression Commentaire',
                    body: "Commentaire supprimé avec succès",
                    color: "bg-success"}
            } 
        else
            render json: {
                status: 500,
                toast: {header: 'Suppression Commentaire',
                    body: "Erreur lors de la suppression",
                    color: "bg-danger"}
            } 
        end
    end
    

    private
    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:context, :post_id, :student_id)
    end

    def valid_account
      unless current_student.valid_account
        flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
        redirect_to "/students/edit"
      end
    end
end
