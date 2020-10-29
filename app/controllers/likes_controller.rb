class LikesController < ApplicationController
    before_action :find_gossip
    before_action :find_like, only: [:destroy]

  def create
    if already_liked?
        flash[:alert] = "Tu ne peux pas liker plus d'une fois"
    else
        @gossip.likes.create(user_id: current_user.id, element_liked_type: "Gossip", element_liked_id:@gossip.id)
    end
    redirect_to gossip_path(@gossip.id)
  end

  def destroy
    if !(already_liked?)
      flash[:alert] = "Tu ne peux pas desaimer ce potin"
    else
      @like.destroy
    end
    redirect_to gossip_path(@gossip)
  end

  private
  
  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def find_like
    @like = @gossip.likes.find(params[:id])
 end

  def already_liked?
    Like.where(user_id: current_user.id, element_liked_id: params[:gossip_id], element_liked_type: "Gossip").exists?
  end
end
