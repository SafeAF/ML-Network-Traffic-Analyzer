require 'rails_helper'

RSpec.describe "services/show", type: :view do
  before(:each) do
    @service = assign(:service, Service.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Distribution/)
    expect(rendered).to match(/Cluster/)
    expect(rendered).to match(/Replication/)
    expect(rendered).to match(/Authority/)
    expect(rendered).to match(/Purpose/)
    expect(rendered).to match(/Watchdog/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/MyText/)
  end
end
