require 'rails_helper'

RSpec.describe "my_apps/show", type: :view do
  before(:each) do
    @my_app = assign(:my_app, MyApp.create!(
      :user => nil,
      :title => "Title",
      :app_id => "App",
      :javascript_origins => "Javascript Origins",
      :secret_key => "Secret Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/App/)
    expect(rendered).to match(/Javascript Origins/)
    expect(rendered).to match(/Secret Key/)
  end
end
