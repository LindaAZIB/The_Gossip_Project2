class CommentsController < ApplicationController

  before_action :authenticate_current_user, only: [:edit, :update, :destroy]
#Impossible de commenter sans connexion 
  def new
    unless current_user
      redirect_to gossip_path(params[:gossip_id]), alert: "Please log in."
    end
    @new_comment = Comment.new(gossip_id:params[:gossip_id])
  end

  def create             
    @new_comment = Comment.new('gossip_id' => params[:gossip_id], 'content' => params[:comment_content])
    @new_comment.user = User.find_by(id: session[:user_id])
    # @gossip = Gossip.new('title' => params[:gossip_title], 'content' => params[:gossip_content])
    # @gossip.user = User.find_by(id: session[:user_id])
  
    if @new_comment.save
      redirect_to gossip_path(@new_comment.gossip_id), notice: "Le commentaire a bien été créé"
      puts 'Le commentaire a été créé !'
      
    else
      redirect_to new_gossip_comment_path, alert: "Certaines informations sont incorrectes : le commentaire ne peut être vide"
    end
  end

  def edit
    @this_comment = Comment.find(params[:id])
  end

  def update
    @this_comment = Comment.find(params[:id])
    @this_comment.update('content' => params[:comment_content])

    if @this_comment.save
      redirect_to gossip_path(@this_comment.gossip_id), notice: "Le commentaire a bien été modifié"
    
    else
      redirect_to this_gossip_comment_path, alert: "Certaines informations sont incorrectes : le commentaire ne peut être vide"
    end
  end

  def destroy
    @this_comment = Comment.find(params[:id])
    @this_comment.destroy
    redirect_to gossip_path(@this_comment.gossip_id), notice: "Ton commentaire a bien été supprimé"
  end

  def show
  end

  def index
  end

  private

  def authenticate_current_user
    unless current_user == Comment.find(params[:id]).user
      redirect_to gossip_path(params[:gossip_id]), alert: "Vous ne pouvez pas modifier ce commentaire"
    end
  end
end