require "rails_helper"

RSpec.describe PacksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/packs").to route_to("packs#index")
    end

    it "routes to #show" do
      expect(:get => "/packs/1").to route_to("packs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/packs").to route_to("packs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/packs/1").to route_to("packs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/packs/1").to route_to("packs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/packs/1").to route_to("packs#destroy", :id => "1")
    end
  end
end
