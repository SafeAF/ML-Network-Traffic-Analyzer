require 'rails_helper'

RSpec.describe "services/index", type: :view do
  before(:each) do
    assign(:services, [
      Service.create!(
        :name => "Name",
        :description => "Description",
        :type => "Type",
        :location => "Location",
        :server_id => 1,
        :webserver_id => 2,
        :cluster_id => 3,
        :user_id => 4,
        :distribution => "Distribution",
        :cluster => "Cluster",
        :replication => "Replication",
        :authority => "Authority",
        :purpose => "Purpose",
        :watchdog => "Watchdog",
        :pid => 5,
        :criticality => 6,
        :priority => 7,
        :network_id => 8,
        :manager_id => 9,
        :devops_id => 10,
        :configuration => "MyText"
      ),
      Service.create!(
        :name => "Name",
        :description => "Description",
        :type => "Type",
        :location => "Location",
        :server_id => 1,
        :webserver_id => 2,
        :cluster_id => 3,
        :user_id => 4,
        :distribution => "Distribution",
        :cluster => "Cluster",
        :replication => "Replication",
        :authority => "Authority",
        :purpose => "Purpose",
        :watchdog => "Watchdog",
        :pid => 5,
        :criticality => 6,
        :priority => 7,
        :network_id => 8,
        :manager_id => 9,
        :devops_id => 10,
        :configuration => "MyText"
      )
    ])
  end

  it "renders a list of services" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Distribution".to_s, :count => 2
    assert_select "tr>td", :text => "Cluster".to_s, :count => 2
    assert_select "tr>td", :text => "Replication".to_s, :count => 2
    assert_select "tr>td", :text => "Authority".to_s, :count => 2
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    assert_select "tr>td", :text => "Watchdog".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
