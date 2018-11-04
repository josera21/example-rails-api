# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "jose@correo.com", uid: "132asddas21", provider: "google")
user2 = User.create(email: "luis@correo.com", uid: "999asddas22", provider: "facebook")

poll = MyPoll.create(title: "Que lenguaje de programacion es el mejor para ti",
					 description: "Queremos saber que lenguajes son los preferidos",
					 expires_at: DateTime.now + 1.year,
					 user: user)

poll2 = MyPoll.create(title: "Que IDE es el mejor para ti",
					 description: "Queremos saber que IDE son los preferidos",
					 expires_at: DateTime.now + 1.year,
					 user: user2)

question = Question.create(description: "Te importa la eficiencia de ejecucion del programa?",
							my_poll: poll)
question2 = Question.create(description: "Te importa la eficiencia de ejecucion del programa?",
							my_poll: poll2)

answer = Answer.create(description: "a) Si, me importa mucho", question: question)
answer2 = Answer.create(description: "a) No, no me importa mucho", question: question2)