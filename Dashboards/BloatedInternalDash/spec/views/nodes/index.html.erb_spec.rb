require 'rails_helper'

RSpec.describe "nodes/index", type: :view do
  before(:each) do
    assign(:nodes, [
      Node.create!(
        :name => "Name",
        :ip => "Ip",
        :hostname => "Hostname"
      ),
      Node.create!(
        :name => "Name",
        :ip => "Ip",
        :hostname => "Hostname"
      )
    ])
  end

  it "renders a list of nodes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Hostname".to_s, :count => 2
  end
end
