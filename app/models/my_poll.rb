class MyPoll < ApplicationRecord
  belongs_to :user, required: true
  has_many :questions
  
  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :expires_at, presence: true

  # Con rails tambien podemos validar relaciones entre tablas
  validates :user, presence: true # Buscara si existe el usuario
  def is_valid?
  	DateTime.now < self.expires_at
  end
end