require 'rails_helper'

RSpec.describe "snippets/edit", type: :view do
  before(:each) do
    @snippet = assign(:snippet, Snippet.create!(
      :name => "MyString",
      :description => "MyString",
      :code => "MyText"
    ))
  end

  it "renders the edit snippet form" do
    render

    assert_select "form[action=?][method=?]", snippet_path(@snippet), "post" do

      assert_select "input#snippet_name[name=?]", "snippet[name]"

      assert_select "input#snippet_description[name=?]", "snippet[description]"

      assert_select "textarea#snippet_code[name=?]", "snippet[code]"
    end
  end
end
