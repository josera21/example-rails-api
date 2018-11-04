require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :request do

	before :each do
		@token = FactoryGirl.create(:token, expires_at: DateTime.now + 1.month)
		@poll = FactoryGirl.create(:poll_with_questions, user: @token.user)
		@question = @poll.questions[0]
	end

	# Otra manera de hacer pruebas, optimizando codigo
	let(:valid_params){ { description: "Ruby", question_id: @question.id } }

	describe "POST /polls/:poll_id/answers" do
		context "con usuario valido" do
			before :each do
				post api_v1_poll_answers_path(@poll),
				{ answer: valid_params, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }
			
			it "cambia el numero de respuestas en +1" do
				expect {
					post api_v1_poll_answers_path(@poll),
					{ answer: valid_params, token: @token.token }
				}.to change(Answer, :count).by(1)
			end

			it "responde con la respuesta creada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["description"]).to eq(valid_params[:description])
			end
		end

		context "con usuario invalido" do
			
		end
	end

	describe "PUT/PATCH /polls/:poll_id/answers/:id" do
		before :each do
			@answer = FactoryGirl.create(:answer,question: @question)
			put api_v1_poll_answer_path(@poll,@answer), 
			{ answer: { description: "Nueva respuesta" }, token: @token.token }
		end

		it { expect(response).to have_http_status(200) }

		it "actualiza los campos indicados" do
			@answer.reload
			expect(@answer.description).to eq("Nueva respuesta")
		end

	end

	describe "DELETE /polls/:poll_id/questions/:id" do
		before :each do
			@answer = FactoryGirl.create(:answer,question: @question)
		end

		it "responde con estatus 200" do
			delete api_v1_poll_answer_path(@poll,@answer), { token: @token.token }
			expect(response).to have_http_status(200)
		end

		it "cambia el contador de Answer en -1" do
			expect {
				delete api_v1_poll_answer_path(@poll,@answer), { token: @token.token }
			}.to change(Answer, :count).by(-1)
		end
	end
end