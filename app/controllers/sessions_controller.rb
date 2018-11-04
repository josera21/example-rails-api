class SessionsController < ApplicationController
  def create
  	auth = request.env["omniauth.auth"]
  	user = User.from_omniauth(auth)

  	if user.persisted?
  		# session es un hash global que tiene Rails
  		session[:user_id] = user.id
  		redirect_to "/", notice: "Ya estas logueado"
  	else
  		redirect_to "/", notice: user.errors.full_messages.to_s
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to "/", notice: "Hasta luego"
  end
end
