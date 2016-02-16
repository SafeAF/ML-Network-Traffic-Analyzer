require 'rails_helper'

RSpec.describe "nodes/edit", type: :view do
  before(:each) do
    @node = assign(:node, Node.create!(
      :name => "MyString",
      :ip => "MyString",
      :hostname => "MyString"
    ))
  end

  it "renders the edit node form" do
    render

    assert_select "form[action=?][method=?]", node_path(@node), "post" do

      assert_select "input#node_name[name=?]", "node[name]"

      assert_select "input#node_ip[name=?]", "node[ip]"

      assert_select "input#node_hostname[name=?]", "node[hostname]"
    end
  end
end
