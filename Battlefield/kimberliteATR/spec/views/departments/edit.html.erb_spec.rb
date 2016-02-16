require 'rails_helper'

RSpec.describe "departments/edit", type: :view do
  before(:each) do
    @department = assign(:department, Department.create!(
      :string => "",
      :string => "",
      :integer => "",
      :text => ""
    ))
  end

  it "renders the edit department form" do
    render

    assert_select "form[action=?][method=?]", department_path(@department), "post" do

      assert_select "input#department_string[name=?]", "department[string]"

      assert_select "input#department_string[name=?]", "department[string]"

      assert_select "input#department_integer[name=?]", "department[integer]"

      assert_select "input#department_text[name=?]", "department[text]"
    end
  end
end
