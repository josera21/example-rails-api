class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  # before_action :authenticate # lo comentamos por que manejamos la autenticacion en cada controlador

  include UserAuthentication

  before_action :set_jbuilder_defaults

  protected
    def authenticate
    	token_str = params[:token]
    	token = Token.find_by(token: token_str)

    	if token.nil? || !token.is_valid? || !@my_app.is_your_token?(token)
    		# render json: { error: "Token invalido"}, status: :unauthorized
        error!("Token invalido", :unauthorized)
    	else
    		@current_user = token.user
    	end
    end

    def authenticate_owner(owner)
      if owner != @current_user
        render json: { errors: "No tienes autorizado editar este recurso" }, status: 401
      end
    end

    def set_jbuilder_defaults
      @errors = []
    end

    def error!(message, status)
      @errors << message # Esto es como hacer un push al arreglo
      response.status = status
      render template: "api/v1/errors"
    end

    def error_array!(array, status)
      @errors = @errors + array
      response.status = status
      render template: "api/v1/errors"
    end
end
