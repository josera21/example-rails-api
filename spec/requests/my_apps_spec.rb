require 'rails_helper'

RSpec.describe "MyApps", type: :request do
  describe "GET /my_apps" do
    it "works! (now write some real specs)" do
      get my_apps_path
      expect(response).to have_http_status(200)
    end
  end
end
