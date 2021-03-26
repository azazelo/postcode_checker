require 'rails_helper'

RSpec.describe "Postcodes", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/postcodes/new"
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /index" do
    it "returns http success" do
      get "/postcodes"
      expect(response).to have_http_status(:success)
    end
  end

end
