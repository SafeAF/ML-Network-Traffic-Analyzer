require 'rails_helper'

RSpec.describe "servers/index", type: :view do
  before(:each) do
    assign(:servers, [
      Server.create!(
        :name => "Name",
        :username => "Username",
        :password => "Password",
        :privkey => "MyText",
        :pubkey => "MyText",
        :key => "MyText",
        :ip => "Ip",
        :hostname => "Hostname",
        :cluster => "Cluster",
        :ipaddr => 1,
        :string => "",
        :machine_id => 2,
        :cluster_id => 3,
        :virtual? => false,
        :up? => false,
        :criticality => 4,
        :priority => 5,
        :network_id => 6,
        :manager_id => 7,
        :os => "Os",
        :devops_id => 8,
        :uptime => 9,
        :system_id => 10,
        :user_id => 11,
        :configuration => "MyText"
      ),
      Server.create!(
        :name => "Name",
        :username => "Username",
        :password => "Password",
        :privkey => "MyText",
        :pubkey => "MyText",
        :key => "MyText",
        :ip => "Ip",
        :hostname => "Hostname",
        :cluster => "Cluster",
        :ipaddr => 1,
        :string => "",
        :machine_id => 2,
        :cluster_id => 3,
        :virtual? => false,
        :up? => false,
        :criticality => 4,
        :priority => 5,
        :network_id => 6,
        :manager_id => 7,
        :os => "Os",
        :devops_id => 8,
        :uptime => 9,
        :system_id => 10,
        :user_id => 11,
        :configuration => "MyText"
      )
    ])
  end

  it "renders a list of servers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "Cluster".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Os".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
