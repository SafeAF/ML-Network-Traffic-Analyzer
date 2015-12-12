require 'rails_helper'

RSpec.describe "departments/new", type: :view do
  before(:each) do
    assign(:department, Department.new(
      :string => "",
      :string => "",
      :integer => "",
      :text => ""
    ))
  end

  it "renders new department form" do
    render

    assert_select "form[action=?][method=?]", departments_path, "post" do

      assert_select "input#department_string[name=?]", "department[string]"

      assert_select "input#department_string[name=?]", "department[string]"

      assert_select "input#department_integer[name=?]", "department[integer]"

      assert_select "input#department_text[name=?]", "department[text]"
    end
  end
end
