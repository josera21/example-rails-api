class Api::V1::AnswersController < Api::V1::MasterApiController
	before_action :authenticate, except: [:index, :show]
	before_action :set_answer, only: [:update, :destroy]
	before_action :set_poll
	before_action(only: [:create, :update, :destroy]) {
		|c| c.authenticate_owner(@poll.user)
	}

	#POST /polls/1/answers
	def create
		@answer = Answer.new(answer_params)

		if @answer.save
			render template: "api/v1/answers/show"
		else
			render json: { error: @answer.errors}, status: :unprocessable_entity
		end
	end

	#PATCH PUT /polls/1/answers/1
	def update
		if @answer.update(answer_params)
			render template: "api/v1/answers/show"
		else
			render json: { error: @answer.errors}, status: :unprocessable_entity
		end
	end

	#DELETE /polls/1/answers/2
	def destroy
		@answer.destroy
		head :ok
	end

	private
	 def answer_params
	 	params.require(:answer).permit(:description, :question_id)
	 end

	 def set_poll
	 	@poll = MyPoll.find(params[:poll_id])
	 end

	 def set_answer
	 	@answer = Answer.find(params[:id])
	 end
end