require 'rails_helper'

RSpec.describe "applications/index", type: :view do
  before(:each) do
    assign(:applications, [
      Application.create!(
        :name => "Name",
        :purpose => "Purpose",
        :description => "Description",
        :hostname => "Hostname",
        :parent_process => "Parent Process",
        :process_id => 1,
        :service => "Service",
        :notice => "Notice",
        :node_id => 2,
        :criticality => 3,
        :priority => 4,
        :machine_id => 5,
        :server_id => 6,
        :user_id => 7,
        :network => "Network",
        :network_id => 8,
        :manager_id => 9,
        :status => "Status",
        :developer_id => 10,
        :pubserver_id => 11
      ),
      Application.create!(
        :name => "Name",
        :purpose => "Purpose",
        :description => "Description",
        :hostname => "Hostname",
        :parent_process => "Parent Process",
        :process_id => 1,
        :service => "Service",
        :notice => "Notice",
        :node_id => 2,
        :criticality => 3,
        :priority => 4,
        :machine_id => 5,
        :server_id => 6,
        :user_id => 7,
        :network => "Network",
        :network_id => 8,
        :manager_id => 9,
        :status => "Status",
        :developer_id => 10,
        :pubserver_id => 11
      )
    ])
  end

  it "renders a list of applications" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Process".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Service".to_s, :count => 2
    assert_select "tr>td", :text => "Notice".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Network".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
