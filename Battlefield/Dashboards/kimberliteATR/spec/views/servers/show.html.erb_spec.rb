require 'rails_helper'

RSpec.describe "servers/show", type: :view do
  before(:each) do
    @server = assign(:server, Server.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/Hostname/)
    expect(rendered).to match(/Cluster/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/Os/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
    expect(rendered).to match(/MyText/)
  end
end
