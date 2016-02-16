require 'rails_helper'

RSpec.describe "servers/edit", type: :view do
  before(:each) do
    @server = assign(:server, Server.create!(
      :name => "MyString",
      :username => "MyString",
      :password => "MyString",
      :privkey => "MyText",
      :pubkey => "MyText",
      :key => "MyText",
      :ip => "MyString",
      :hostname => "MyString",
      :cluster => "MyString",
      :ipaddr => 1,
      :string => "",
      :machine_id => 1,
      :cluster_id => 1,
      :virtual? => false,
      :up? => false,
      :criticality => 1,
      :priority => 1,
      :network_id => 1,
      :manager_id => 1,
      :os => "MyString",
      :devops_id => 1,
      :uptime => 1,
      :system_id => 1,
      :user_id => 1,
      :configuration => "MyText"
    ))
  end

  it "renders the edit server form" do
    render

    assert_select "form[action=?][method=?]", server_path(@server), "post" do

      assert_select "input#server_name[name=?]", "server[name]"

      assert_select "input#server_username[name=?]", "server[username]"

      assert_select "input#server_password[name=?]", "server[password]"

      assert_select "textarea#server_privkey[name=?]", "server[privkey]"

      assert_select "textarea#server_pubkey[name=?]", "server[pubkey]"

      assert_select "textarea#server_key[name=?]", "server[key]"

      assert_select "input#server_ip[name=?]", "server[ip]"

      assert_select "input#server_hostname[name=?]", "server[hostname]"

      assert_select "input#server_cluster[name=?]", "server[cluster]"

      assert_select "input#server_ipaddr[name=?]", "server[ipaddr]"

      assert_select "input#server_string[name=?]", "server[string]"

      assert_select "input#server_machine_id[name=?]", "server[machine_id]"

      assert_select "input#server_cluster_id[name=?]", "server[cluster_id]"

      assert_select "input#server_virtual?[name=?]", "server[virtual?]"

      assert_select "input#server_up?[name=?]", "server[up?]"

      assert_select "input#server_criticality[name=?]", "server[criticality]"

      assert_select "input#server_priority[name=?]", "server[priority]"

      assert_select "input#server_network_id[name=?]", "server[network_id]"

      assert_select "input#server_manager_id[name=?]", "server[manager_id]"

      assert_select "input#server_os[name=?]", "server[os]"

      assert_select "input#server_devops_id[name=?]", "server[devops_id]"

      assert_select "input#server_uptime[name=?]", "server[uptime]"

      assert_select "input#server_system_id[name=?]", "server[system_id]"

      assert_select "input#server_user_id[name=?]", "server[user_id]"

      assert_select "textarea#server_configuration[name=?]", "server[configuration]"
    end
  end
end
