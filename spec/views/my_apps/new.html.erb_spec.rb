require 'rails_helper'

RSpec.describe "my_apps/new", type: :view do
  before(:each) do
    assign(:my_app, MyApp.new(
      :user => nil,
      :title => "MyString",
      :app_id => "MyString",
      :javascript_origins => "MyString",
      :secret_key => "MyString"
    ))
  end

  it "renders new my_app form" do
    render

    assert_select "form[action=?][method=?]", my_apps_path, "post" do

      assert_select "input[name=?]", "my_app[user_id]"

      assert_select "input[name=?]", "my_app[title]"

      assert_select "input[name=?]", "my_app[app_id]"

      assert_select "input[name=?]", "my_app[javascript_origins]"

      assert_select "input[name=?]", "my_app[secret_key]"
    end
  end
end
