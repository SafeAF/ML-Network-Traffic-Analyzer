require 'rails_helper'

RSpec.describe "snippets/show", type: :view do
  before(:each) do
    @snippet = assign(:snippet, Snippet.create!(
      :name => "Name",
      :description => "Description",
      :code => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/MyText/)
  end
end
