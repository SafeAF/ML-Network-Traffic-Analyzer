require 'rails_helper'

RSpec.describe "clusterbots/show", type: :view do
  before(:each) do
    @clusterbot = assign(:clusterbot, Clusterbot.create!(
      :name => "Name",
      :hostname => "Hostname",
      :ip => "Ip",
      :cluster_id => 1,
      :uptime => 2,
      :configuration => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Hostname/)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
