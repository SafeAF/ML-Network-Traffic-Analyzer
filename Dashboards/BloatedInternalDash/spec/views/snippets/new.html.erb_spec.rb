require 'rails_helper'

RSpec.describe "snippets/new", type: :view do
  before(:each) do
    assign(:snippet, Snippet.new(
      :name => "MyString",
      :description => "MyString",
      :code => "MyText"
    ))
  end

  it "renders new snippet form" do
    render

    assert_select "form[action=?][method=?]", snippets_path, "post" do

      assert_select "input#snippet_name[name=?]", "snippet[name]"

      assert_select "input#snippet_description[name=?]", "snippet[description]"

      assert_select "textarea#snippet_code[name=?]", "snippet[code]"
    end
  end
end
