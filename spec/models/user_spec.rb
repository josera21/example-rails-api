require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should_not allow_value("jose@correo").for(:email) }
  it { should allow_value("jose@correo.com").for(:email) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }

  # La diferencia entre parentesis y llaves en los test, es que las llaves son bloques de codigo
  # En cambio con los parentesis, se espera algo que retorne el metodo

  it "deberia crear un usuario si el uid y el provider no existen" do
  	expect{
  		User.from_omniauth({uid: "12345", provider: "facebook", info: {email: "u@mail.com"} })
  	}.to change(User, :count).by(1)
  end

  it "deberia encontrar un usuario si el uid y el provider ya existen" do
  	user = FactoryGirl.create(:user)
  	expect{
  		User.from_omniauth({uid: user.uid, provider: user.provider, info: {email: "u@mail.com"}})
  	}.to change(User, :count).by(0)
  end

  it "deberia retornar el usuario encontrado si el uid y el provider ya existen" do
  	user = FactoryGirl.create(:user)
  	expect(
  		User.from_omniauth({uid: user.uid, provider: user.provider})
  	).to eq(user)
  end
end
