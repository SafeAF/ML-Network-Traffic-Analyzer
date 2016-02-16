require 'rails_helper'

RSpec.describe "services/edit", type: :view do
  before(:each) do
    @service = assign(:service, Service.create!(
      :name => "MyString",
      :description => "MyString",
      :type => "",
      :location => "MyString",
      :server_id => 1,
      :webserver_id => 1,
      :cluster_id => 1,
      :user_id => 1,
      :distribution => "MyString",
      :cluster => "MyString",
      :replication => "MyString",
      :authority => "MyString",
      :purpose => "MyString",
      :watchdog => "MyString",
      :pid => 1,
      :criticality => 1,
      :priority => 1,
      :network_id => 1,
      :manager_id => 1,
      :devops_id => 1,
      :configuration => "MyText"
    ))
  end

  it "renders the edit service form" do
    render

    assert_select "form[action=?][method=?]", service_path(@service), "post" do

      assert_select "input#service_name[name=?]", "service[name]"

      assert_select "input#service_description[name=?]", "service[description]"

      assert_select "input#service_type[name=?]", "service[type]"

      assert_select "input#service_location[name=?]", "service[location]"

      assert_select "input#service_server_id[name=?]", "service[server_id]"

      assert_select "input#service_webserver_id[name=?]", "service[webserver_id]"

      assert_select "input#service_cluster_id[name=?]", "service[cluster_id]"

      assert_select "input#service_user_id[name=?]", "service[user_id]"

      assert_select "input#service_distribution[name=?]", "service[distribution]"

      assert_select "input#service_cluster[name=?]", "service[cluster]"

      assert_select "input#service_replication[name=?]", "service[replication]"

      assert_select "input#service_authority[name=?]", "service[authority]"

      assert_select "input#service_purpose[name=?]", "service[purpose]"

      assert_select "input#service_watchdog[name=?]", "service[watchdog]"

      assert_select "input#service_pid[name=?]", "service[pid]"

      assert_select "input#service_criticality[name=?]", "service[criticality]"

      assert_select "input#service_priority[name=?]", "service[priority]"

      assert_select "input#service_network_id[name=?]", "service[network_id]"

      assert_select "input#service_manager_id[name=?]", "service[manager_id]"

      assert_select "input#service_devops_id[name=?]", "service[devops_id]"

      assert_select "textarea#service_configuration[name=?]", "service[configuration]"
    end
  end
end
