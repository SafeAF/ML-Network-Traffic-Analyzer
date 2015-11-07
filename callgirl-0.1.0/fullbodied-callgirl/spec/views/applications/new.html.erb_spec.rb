require 'rails_helper'

RSpec.describe "applications/new", type: :view do
  before(:each) do
    assign(:application, Application.new(
      :name => "MyString",
      :purpose => "MyString",
      :description => "MyString",
      :hostname => "MyString",
      :parent_process => "MyString",
      :process_id => 1,
      :service => "MyString",
      :notice => "MyString",
      :node_id => 1,
      :criticality => 1,
      :priority => 1,
      :machine_id => 1,
      :server_id => 1,
      :user_id => 1,
      :network => "MyString",
      :network_id => 1,
      :manager_id => 1,
      :status => "MyString",
      :developer_id => 1,
      :pubserver_id => 1
    ))
  end

  it "renders new application form" do
    render

    assert_select "form[action=?][method=?]", applications_path, "post" do

      assert_select "input#application_name[name=?]", "application[name]"

      assert_select "input#application_purpose[name=?]", "application[purpose]"

      assert_select "input#application_description[name=?]", "application[description]"

      assert_select "input#application_hostname[name=?]", "application[hostname]"

      assert_select "input#application_parent_process[name=?]", "application[parent_process]"

      assert_select "input#application_process_id[name=?]", "application[process_id]"

      assert_select "input#application_service[name=?]", "application[service]"

      assert_select "input#application_notice[name=?]", "application[notice]"

      assert_select "input#application_node_id[name=?]", "application[node_id]"

      assert_select "input#application_criticality[name=?]", "application[criticality]"

      assert_select "input#application_priority[name=?]", "application[priority]"

      assert_select "input#application_machine_id[name=?]", "application[machine_id]"

      assert_select "input#application_server_id[name=?]", "application[server_id]"

      assert_select "input#application_user_id[name=?]", "application[user_id]"

      assert_select "input#application_network[name=?]", "application[network]"

      assert_select "input#application_network_id[name=?]", "application[network_id]"

      assert_select "input#application_manager_id[name=?]", "application[manager_id]"

      assert_select "input#application_status[name=?]", "application[status]"

      assert_select "input#application_developer_id[name=?]", "application[developer_id]"

      assert_select "input#application_pubserver_id[name=?]", "application[pubserver_id]"
    end
  end
end
