class Api::V1::UsersController < Api::V1::MasterApiController
	# POST
	def create
		if !params[:auth]
			render json: { error: "Auth param is missing" }
		else
			@user = User.from_omniauth(params[:auth])

			@token = @user.tokens.create(my_app: @my_app)

			render "api/v1/users/show"
		end
	end
end