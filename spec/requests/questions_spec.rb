require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

	before :each do
		@token = FactoryGirl.create(:token, expires_at: DateTime.now + 1.month)
		@poll = FactoryGirl.create(:poll_with_questions, user: @token.user)
	end

	describe "GET /polls/:poll_id/questions" do
		before :each do
			get "/api/v1/polls/#{@poll.id}/questions"
		end

		it { expect(response).to have_http_status(200) }

		it "mande la lista de preguntas para la encuesta" do
			json = JSON.parse(response.body)
			expect(json.length).to eq(@poll.questions.count)
		end

		it "manda los atributos de la pregunta" do
			json_array = JSON.parse(response.body)
			question = json_array["data"][0] # Agarro la primera pregunta pregunta
			expect(question["attributes"].keys).to contain_exactly("id", "description", "my_poll_id","created_at", "updated_at")
		end
	end

	describe "GET /polls/:poll_id/questions/:id" do
		before :each do
			@question = @poll.questions[0]

			get api_v1_poll_question_path(@poll, @question)
		end

		it { expect(response).to have_http_status(200) }

		it "esperamos que nos mande la pregunta solicitada en JSON" do
			json = JSON.parse(response.body)
			expect(json["data"]["attributes"]["description"]).to eq(@question.description)
			expect(json["data"]["attributes"]["id"]).to eq(@question.id)
		end
	end

	describe "POST /polls/:poll_id/questions" do
		context "con usuario valido" do
			before :each do
				post api_v1_poll_questions_path(@poll),
				{ question: { description: "Cual es tu lenguaje favorito?" }, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }
			

			it "cambia el numero de preguntas +1" do
				expect {
					post api_v1_poll_questions_path(@poll),
					{ question: { description: "Cual es tu lenguaje favorito?" }, token: @token.token }
				}.to change(Question, :count).by(1)
			end

			it "responde con la pregunta creada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["description"]).to eq("Cual es tu lenguaje favorito?")
			end
		end

		context "con usuario invalido" do
			before :each do
				new_user = FactoryGirl.create(:dummy_user)
				@new_token = FactoryGirl.create(:token,user:new_user,expires_at: DateTime.now + 1.month)
				post api_v1_poll_questions_path(@poll),
				{ question: { description: "Cual es tu lenguaje favorito?" }, token: @new_token.token }
			end

			it { expect(response).to have_http_status(401) }

			it "cambia el numero de preguntas a cero" do
				expect {
					post api_v1_poll_questions_path(@poll),
					{ question: { description: "Cual es tu lenguaje favorito?" },token: @new_token.token }
				}.to change(Question, :count).by(0)
			end
		end
	end

	describe "PUT/PATCH /polls/:poll_id/questions/:id" do
		before :each do
			@question = @poll.questions[0]

			patch api_v1_poll_question_path(@poll, @question),
			{ question: { description: "Hola mundo" }, token: @token.token }
		end

		it { expect(response).to have_http_status(200) }

		it "Actualiza los datos indicados" do
			json = JSON.parse(response.body)
			expect(json["data"]["attributes"]["description"]).to eq("Hola mundo")
		end
	end

	describe "DELETE /polls/:poll_id/questions/:id" do
		before :each do
			@question = @poll.questions[0]
		end

		it "responde con status 200" do
			delete api_v1_poll_question_path(@poll, @question), { token: @token.token }
			expect(response).to have_http_status(200)
		end

		it "Elimina la pregunta" do
			delete api_v1_poll_question_path(@poll, @question), { token: @token.token }
			expect(Question.where(id: @question.id)).to be_empty
		end

		it "reduce el conteo de preguntas en -1" do
			expect {
				delete api_v1_poll_question_path(@poll, @question), { token: @token.token }
			}.to change(Question,:count).by(-1)
		end
	end
end