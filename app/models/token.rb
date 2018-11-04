class Token < ApplicationRecord
  belongs_to :user
  belongs_to :my_app
  before_create :generate_token

  def is_valid?
  	DateTime.now < self.expires_at
  end

  private
  	def generate_token
  		# El begin es la manera en que se hace un Do While en Ruby
  		# Lo que haces es generar un token random mientras el generado se encuentre ya asignado
  		begin
  			self.token = SecureRandom.hex
  		end while Token.where(token: self.token).any?
  		# Este es un helper, que va a tomar la fecha de hoy y le  va a sumar 1 mes
  		self.expires_at ||= 1.month.from_now
  	end
end
