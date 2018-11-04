require 'rails_helper'

# Si se le colaca una "x" antes del it, colocara el test como pendiente

RSpec.describe Api::V1::MyPollsController, type: :request do

	let(:my_app){ FactoryGirl.create(:my_app, user: FactoryGirl.create(:sequence_user)) }
	let(:secret_key_param){ {secret_key: my_app.secret_key} }
	
	let(:valid_params){ { 
		token: @token.token, secret_key: my_app.secret_key, 
			poll: {title: "Hola mundo", 
				description: "suhdasuidhisaudisabdiasuhdisa dasiis bdisab", 
				expires_at: DateTime.now
			}
		}
	}

	let(:unvalid_params){ {
		token: @token.token, secret_key: my_app.secret_key, 
			poll: {title: "Hola mundo", 
				# Sin description 
				expires_at: DateTime.now
			}
		}
	}

	let(:valid_update_params) { { 
		token: @token.token, secret_key: my_app.secret_key, 
			poll: {title: "Nuevo titulo"}
		}
	}

	describe "GET /polls" do
		before :each do
			FactoryGirl.create_list(:my_poll, 10) # del factory my_poll crea 10
			get "/api/v1/polls", params: secret_key_param
		end

		it { have_http_status(200) }

		it "mande la lista de encuestas" do
			json = JSON.parse(response.body)
			puts json
			expect(json["data"].length).to eq(MyPoll.count)
		end
	end

	describe "GET /polls/:id" do
		before :each do
			@poll = FactoryGirl.create(:my_poll) # del factory my_poll crea 10
			get "/api/v1/polls/#{@poll.id}", params: secret_key_param
		end

		it { expect(response).to have_http_status(200) }

		it "manda la encuesta solicitada" do
			json = JSON.parse(response.body)
			#puts "\n \n -- #{json} --\n \n" # para ver los resultados en consola
			# puts "\n \n -- #{@poll.id} --\n \n"
			expect(json["data"]["id"]).to eq(@poll.id)
		end

		it "manda los atributos de la encuesta" do
			json = JSON.parse(response.body)
			expect(json["data"]["attributes"].keys).to contain_exactly("id", "title", "description", "expires_at", "user_id","created_at","updated_at")
		end
	end

	describe "POST /polls" do
		context "con token valido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				post "/api/v1/polls", params: valid_params
			end
			it { expect(response).to have_http_status(200) }

			it "crea una nueva encuesta" do
				expect {
					post "/api/v1/polls", params: valid_params
				}.to change(MyPoll, :count).by(1)
			end

			it "responde con la encuesta creada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["title"]).to eq("Hola mundo")
			end

		end

		context "con token invalido" do
			before :each do
				post "/api/v1/polls"
			end
			it { expect(response).to have_http_status(401) }
		end

		context "unvalid params" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				post "/api/v1/polls", params: unvalid_params
			end

			it { expect(response).to have_http_status(422) }
			it "responde con los errores al guardar la encuesta" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "PATCH /polls/:id" do
		context "con un token valido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				@poll = FactoryGirl.create(:my_poll, user: @token.user)
				patch api_v1_poll_path(@poll), params: valid_update_params
			end
			it { expect(response).to have_http_status(200) }

			it "actualiza la encuesta indicada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["title"]).to eq("Nuevo titulo")
			end
		end

		context "con un token invalido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				@poll = FactoryGirl.create(:my_poll, user: FactoryGirl.create(:dummy_user))
				patch api_v1_poll_path(@poll), params: valid_update_params
			end
			it { expect(response).to have_http_status(401) }
		end
	end

	describe "DELETE /polls/:id" do
		context "con un token valido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				@poll = FactoryGirl.create(:my_poll, user: @token.user)
			end
			it { delete api_v1_poll_path(@poll), params: { token: @token.token, secret_key: my_app.secret_key }
				json = JSON.parse(response.body)
				puts json
				expect(response).to have_http_status(200) 
			}

			it "elimina la encuesta indicada" do
				expect {
					delete api_v1_poll_path(@poll), params: { token: @token.token, secret_key: my_app.secret_key }
				}.to change(MyPoll, :count).by(-1)
			end
		end

		context "con un token invalido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes, my_app: my_app)
				@poll = FactoryGirl.create(:my_poll, user: FactoryGirl.create(:dummy_user))
				delete api_v1_poll_path(@poll), params: { token: @token.token }
			end
			it { expect(response).to have_http_status(401) }
		end
	end

end
