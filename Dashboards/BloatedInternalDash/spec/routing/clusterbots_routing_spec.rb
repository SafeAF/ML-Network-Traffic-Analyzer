require "rails_helper"

RSpec.describe ClusterbotsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/clusterbots").to route_to("clusterbots#index")
    end

    it "routes to #new" do
      expect(:get => "/clusterbots/new").to route_to("clusterbots#new")
    end

    it "routes to #show" do
      expect(:get => "/clusterbots/1").to route_to("clusterbots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/clusterbots/1/edit").to route_to("clusterbots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clusterbots").to route_to("clusterbots#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/clusterbots/1").to route_to("clusterbots#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/clusterbots/1").to route_to("clusterbots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clusterbots/1").to route_to("clusterbots#destroy", :id => "1")
    end

  end
end
