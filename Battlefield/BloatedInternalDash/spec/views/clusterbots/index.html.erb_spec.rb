require 'rails_helper'

RSpec.describe "clusterbots/index", type: :view do
  before(:each) do
    assign(:clusterbots, [
      Clusterbot.create!(
        :name => "Name",
        :hostname => "Hostname",
        :ip => "Ip",
        :cluster_id => 1,
        :uptime => 2,
        :configuration => "MyText"
      ),
      Clusterbot.create!(
        :name => "Name",
        :hostname => "Hostname",
        :ip => "Ip",
        :cluster_id => 1,
        :uptime => 2,
        :configuration => "MyText"
      )
    ])
  end

  it "renders a list of clusterbots" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
