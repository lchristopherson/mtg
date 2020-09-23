require "rails_helper"

RSpec.describe DecksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/decks").to route_to("decks#index")
    end

    it "routes to #show" do
      expect(:get => "/decks/1").to route_to("decks#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/decks").to route_to("decks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/decks/1").to route_to("decks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/decks/1").to route_to("decks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/decks/1").to route_to("decks#destroy", :id => "1")
    end
  end
end
