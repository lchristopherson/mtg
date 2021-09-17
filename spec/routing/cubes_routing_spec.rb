require "rails_helper"

RSpec.describe CubesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cubes").to route_to("cubes#index")
    end

    it "routes to #show" do
      expect(:get => "/cubes/1").to route_to("cubes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cubes").to route_to("cubes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cubes/1").to route_to("cubes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cubes/1").to route_to("cubes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cubes/1").to route_to("cubes#destroy", :id => "1")
    end
  end
end
