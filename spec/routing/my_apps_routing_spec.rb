require "rails_helper"

RSpec.describe MyAppsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/my_apps").to route_to("my_apps#index")
    end

    it "routes to #new" do
      expect(:get => "/my_apps/new").to route_to("my_apps#new")
    end

    it "routes to #show" do
      expect(:get => "/my_apps/1").to route_to("my_apps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/my_apps/1/edit").to route_to("my_apps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/my_apps").to route_to("my_apps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/my_apps/1").to route_to("my_apps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/my_apps/1").to route_to("my_apps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/my_apps/1").to route_to("my_apps#destroy", :id => "1")
    end

  end
end
