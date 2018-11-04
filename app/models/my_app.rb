class MyApp < ApplicationRecord
  belongs_to :user
  has_many :tokens
  validates :title, presence: true
  validates :user, presence: true
  validates :secret_key, uniqueness: true
  validates :app_id, uniqueness: true

  before_create :generate_app_id
  before_create :generate_secret_key

  def is_your_token?(token)
    # Se necesita cerrar en llaves ese query para que la consulta la haga en tokens y no en my_app 
    self.tokens.where(tokens: { id: token.id }).any?
  end

  def is_valid_origin?(domain)
    self.javascript_origins.split(",").include?(domain)
  end

  private
  	def generate_app_id
  		begin
  			self.app_id = SecureRandom.hex
  		end while MyApp.where(app_id: self.app_id).any?
  	end

  	def generate_secret_key
  		begin
  			self.secret_key = SecureRandom.hex
  		end while MyApp.where(secret_key: self.secret_key).any?
  	end
end
