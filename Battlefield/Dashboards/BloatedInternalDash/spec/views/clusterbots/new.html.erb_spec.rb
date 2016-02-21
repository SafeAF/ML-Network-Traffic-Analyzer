require 'rails_helper'

RSpec.describe "clusterbots/new", type: :view do
  before(:each) do
    assign(:clusterbot, Clusterbot.new(
      :name => "MyString",
      :hostname => "MyString",
      :ip => "MyString",
      :cluster_id => 1,
      :uptime => 1,
      :configuration => "MyText"
    ))
  end

  it "renders new clusterbot form" do
    render

    assert_select "form[action=?][method=?]", clusterbots_path, "post" do

      assert_select "input#clusterbot_name[name=?]", "clusterbot[name]"

      assert_select "input#clusterbot_hostname[name=?]", "clusterbot[hostname]"

      assert_select "input#clusterbot_ip[name=?]", "clusterbot[ip]"

      assert_select "input#clusterbot_cluster_id[name=?]", "clusterbot[cluster_id]"

      assert_select "input#clusterbot_uptime[name=?]", "clusterbot[uptime]"

      assert_select "textarea#clusterbot_configuration[name=?]", "clusterbot[configuration]"
    end
  end
end
