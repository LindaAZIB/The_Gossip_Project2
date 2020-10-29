class SessionsController < ApplicationController

  def new  #correspond à la page de login
  end

  def create #effectuera l'authentification (traitement des informations saisies dans la page login et sauvegarde de l'info de l'utilisateur connecté dans session
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:user_email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:user_password])
      log_in(user)

       # on va cuisiner le cookie pour l'utilisateur
      remember(user)

      redirect_to gossips_path(current_user), notice: "Vous êtes connecté" #Redirige vers la page d'accueil 
    
    else
     flash.now.alert = "Invalid email or password"
    render "new"
    end
  end

  def destroy #correspond à la déconnection
    #session[:user_id] = nil 
    log_out(current_user)
    redirect_to gossips_path
  end
end

