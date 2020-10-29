class CitiesController < ApplicationController
    def show
        @city_searched = City.find(params[:id])
        @list_gossips = Gossip.all
        
        @list_gossips_this_city = []
        
        @list_gossips.each do |gossip|
            if @city_searched.id == gossip.user.city_id
                @list_gossips_this_city << gossip
            end
        end

    end
end
