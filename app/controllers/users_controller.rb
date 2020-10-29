require 'bcrypt'

class UsersController < ApplicationController
	include BCrypt

	def new
		@new_user = User.new
	end

	def create
		if params[:user_password] == params[:user_authentification]
			@new_user = User.new('first_name' => params[:user_first_name],'last_name' => params[:user_last_name],'pseudo' => params[:user_pseudo],'email' => params[:user_email],'password' => params[:user_password],'description' => params[:user_description],'age' => params[:user_age].to_i)
			
			if @new_user.save
				redirect_to gossips_path, notice: "Le profil a bien été créé"
				log_in(@new_user)
				puts "le profil est connecté"
			else
				redirect_to new_user_path, alert: "Certaines informations sont incorrectes : Veuillez saisir tous les champs"
			end
		
			@new_user = User.update('city_id' => City.find_by(name: params[:user_city]).id) if !City.find_by(name: params[:user_city]).nil?
		
		else
			redirect_to new_user_path, alert: "Erreur, les deux mots de passe ne sont pas les mêmes"
		end
	end

	def show
		@user_searched = User.find(params[:id]) 
	end
end
