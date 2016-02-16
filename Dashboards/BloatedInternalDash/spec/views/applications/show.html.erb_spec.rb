require 'rails_helper'

RSpec.describe "applications/show", type: :view do
  before(:each) do
    @application = assign(:application, Application.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Purpose/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Hostname/)
    expect(rendered).to match(/Parent Process/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Service/)
    expect(rendered).to match(/Notice/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/Network/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
  end
end
