require 'rails_helper'

RSpec.describe "my_apps/index", type: :view do
  before(:each) do
    assign(:my_apps, [
      MyApp.create!(
        :user => nil,
        :title => "Title",
        :app_id => "App",
        :javascript_origins => "Javascript Origins",
        :secret_key => "Secret Key"
      ),
      MyApp.create!(
        :user => nil,
        :title => "Title",
        :app_id => "App",
        :javascript_origins => "Javascript Origins",
        :secret_key => "Secret Key"
      )
    ])
  end

  it "renders a list of my_apps" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "App".to_s, :count => 2
    assert_select "tr>td", :text => "Javascript Origins".to_s, :count => 2
    assert_select "tr>td", :text => "Secret Key".to_s, :count => 2
  end
end
