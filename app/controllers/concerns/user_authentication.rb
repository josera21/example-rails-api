module UserAuthentication
	extend ActiveSupport::Concern

	def user_signed_in?
		!current_user.nil?
	end

	def current_user
		# Aqui es donde utilizo el hash global session
		# User.find(session[:user_id]) # Con find levantaba una exeption cuando no lo encontraba
		User.where(id: session[:user_id]).first
	end

	def authenticate_user!
		redirect_to("/", notice: "Tienes que iniciar sesion") unless user_signed_in?
	end
end