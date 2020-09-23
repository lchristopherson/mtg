require 'rails_helper'

RSpec.describe "Drafters", type: :request do
  describe "GET /drafters" do
    it "works! (now write some real specs)" do
      get drafters_path
      expect(response).to have_http_status(200)
    end
  end
end
