require 'rails_helper'

RSpec.describe "Clusterbots", type: :request do
  describe "GET /clusterbots" do
    it "works! (now write some real specs)" do
      get clusterbots_path
      expect(response).to have_http_status(200)
    end
  end
end
