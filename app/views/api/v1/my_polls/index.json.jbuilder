# Nos permite crear objetos a partir del primer parametro, los demas argumentos son atributos
# json.(poll, :id, :title, :description, :user_id, :expires_at)
# Para respetar la estructura que deberia tener un jsonAPI, trabajaremos de la siguiente manera

json.partial! partial: "api/v1/resource",  collection: @polls, as: :resource
