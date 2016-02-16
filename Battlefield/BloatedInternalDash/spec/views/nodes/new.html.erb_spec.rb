require 'rails_helper'

RSpec.describe "nodes/new", type: :view do
  before(:each) do
    assign(:node, Node.new(
      :name => "MyString",
      :ip => "MyString",
      :hostname => "MyString"
    ))
  end

  it "renders new node form" do
    render

    assert_select "form[action=?][method=?]", nodes_path, "post" do

      assert_select "input#node_name[name=?]", "node[name]"

      assert_select "input#node_ip[name=?]", "node[ip]"

      assert_select "input#node_hostname[name=?]", "node[hostname]"
    end
  end
end
