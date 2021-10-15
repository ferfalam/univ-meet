class Students::PostsController < ApplicationController
  before_action :authenticate_student!
  before_action :valid_account
  before_action :set_post, only: [:update, :destroy]
  def index
    @posts = current_student.posts.order(created_at: :desc)
  end

  def create
      @post = Post.new(post_params)
      @post.student_id = current_student.id
      if @post.save
          render json: {
              status: 200,
              post: Post.order(created_at: :desc),
              toast: {header: 'Création Post',
                  body: "Post créée avec succès",
                  color: "bg-success"}
          } 
      else
          render json: {
              status: 500,
              errors: @post.errors.messages
          } 
      end
  end
    

  def update
    if @post.update(post_params)
        render json: {
            status: 200,
            post: @post,
            message: {
                text: "Post modifiée avec succès",
                color: "bg-success"}
        } 
    else
        render json: {
            status: 500,
            errors: @post.errors.messages
        } 
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
        render json: {
            status: 200,
            toast: {header: 'Suppression Post',
                body: "Post supprimer avec succès",
                color: "bg-success"}
        } 
    else
        render json: {
            status: 500,
            toast: {header: 'Suppression Post',
                body: "Erreur lors de la suppression",
                color: "bg-danger"}
        } 
    end
  end
  
  def favorite
    @favorite = Favorite.new({
      post_id: params[:id],
      student_id: current_student.id
    })    

    if @favorite.save
      render json: {
            status: 200,
        } 
    else
        render json: {
            status: 500
        } 
    end
  end

  def unfavorite
    @favorite = Favorite.where(
      post_id: params[:id],
      student_id: current_student.id
    )    

    if @favorite && @favorite.destroy
      render json: {
            status: 200,
        } 
    else
        render json: {
            status: 500
        } 
    end
  end
  

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def valid_account
    unless current_student.valid_account
        flash[:notice] = "Votre compte n'est pas encore valide, veuillez patienter"
        redirect_to "/universities/edit"
    end
  end
end
