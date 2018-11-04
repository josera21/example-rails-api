class WelcomeController < ApplicationController
  def index
  end

  def app
  	@my_apps = current_user.my_apps
  end
end
