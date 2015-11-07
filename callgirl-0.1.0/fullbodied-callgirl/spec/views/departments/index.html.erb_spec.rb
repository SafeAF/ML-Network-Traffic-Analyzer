require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, [
      Department.create!(
        :string => "",
        :string => "",
        :integer => "",
        :text => ""
      ),
      Department.create!(
        :string => "",
        :string => "",
        :integer => "",
        :text => ""
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
