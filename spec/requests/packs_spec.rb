require 'rails_helper'

RSpec.describe "Packs", type: :request do
  describe "GET /packs" do
    it "works! (now write some real specs)" do
      get packs_path
      expect(response).to have_http_status(200)
    end
  end
end
