module ApplicationHelper
	def user_signed_in?
		!current_user.nil?
	end

	def current_user
		# Aqui es donde utilizo el hash global session
		# User.find(session[:user_id]) # Con find levantaba una exeption cuando no lo encontraba
		User.where(id: session[:user_id]).first
	end
end
