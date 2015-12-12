require 'rails_helper'

RSpec.describe "snippets/index", type: :view do
  before(:each) do
    assign(:snippets, [
      Snippet.create!(
        :name => "Name",
        :description => "Description",
        :code => "MyText"
      ),
      Snippet.create!(
        :name => "Name",
        :description => "Description",
        :code => "MyText"
      )
    ])
  end

  it "renders a list of snippets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
