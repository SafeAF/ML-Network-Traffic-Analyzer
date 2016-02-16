require 'rails_helper'

RSpec.describe "nodes/show", type: :view do
  before(:each) do
    @node = assign(:node, Node.create!(
      :name => "Name",
      :ip => "Ip",
      :hostname => "Hostname"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/Hostname/)
  end
end
