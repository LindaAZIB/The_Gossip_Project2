class GossipsController < ApplicationController
  
  before_action :authenticate_current_user, only: [:edit, :update, :destroy]

	def team
  end

  def contact
  end

  def index
    @list_gossips = Gossip.all
  end

  def show
     @gossip_searched = Gossip.find(params[:id])
     @comments_linked = []
     Comment.all.each do |comment|
       if @gossip_searched.id == comment.gossip_id
        @comments_linked << comment
       end
     end
  end

  def new
    unless current_user
      redirect_to gossips_path, alert: "Please log in."
    end
  	@gossip = Gossip.new
  end

  def create 
    @gossip = Gossip.new('title' => params[:gossip_title], 'content' => params[:gossip_content])
    
    @gossip.user = current_user
                      
    if @gossip.save
      redirect_to gossips_path, notice: "Le potin #{@gossip.title} a bien été créé !"
    else
      redirect_to new_gossip_path, alert: "Certaines informations sont incorrectes : le titre doit faire entre 3 et 30 caractères"
    end    
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update('title'=> params[:gossip_title],'content'=> params[:gossip_content])
      redirect_to gossips_path , notice: "Ton gossip a bien été mis à jour"
    else
      redirect_to edit_gossip_path
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path, notice: "Ton gossip a bien été supprimé"
  end

  private

  def authenticate_current_user
    unless current_user == Gossip.find(params[:id]).user
      redirect_to gossip_path(params[:id]), alert: "Vous ne pouvez pas modifier ce potin"
    end
  end
end