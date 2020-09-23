require "rails_helper"

RSpec.describe DraftersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/drafters").to route_to("drafters#index")
    end

    it "routes to #show" do
      expect(:get => "/drafters/1").to route_to("drafters#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/drafters").to route_to("drafters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/drafters/1").to route_to("drafters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/drafters/1").to route_to("drafters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/drafters/1").to route_to("drafters#destroy", :id => "1")
    end
  end
end
