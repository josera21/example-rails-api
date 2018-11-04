require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do 
	describe "POST /users" do
		# El before each se puede hacer cuando estamos dentro de un bloque describe o context
		# lo que hace es que se ejecuta el codigo dentro de before antes de cualquier prueba
		# Asi nos ahorramos de escribir el mismo codigo repetido en varios lados
		let(:my_app) { FactoryGirl.create(:my_app, user: FactoryGirl.create(:sequence_user)) }

		before :each do
			auth = { provider: "facebook", uid: "12dasdf123", info: { email: "jose@correo.com" } }
			post "/api/v1/users", params: {auth: auth, secret_key: my_app.secret_key}
		end

		it { expect(response).to have_http_status(200) }

		it { change(User, :count).by(1) }

		it "responds with the user found or created" do
			json = JSON.parse(response.body)
			puts json
			expect(json["data"]["email"]).to eq("jose@correo.com")
		end

		it "respond with the token" do
			token = Token.last
			expect(token.my_app).to_not be_nil
		end
	end
end