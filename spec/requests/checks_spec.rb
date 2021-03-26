require 'rails_helper'

RSpec.describe "Checks", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/checks/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "post /checks" do
    it "returns http success" do
      post "/checks", params: { check: { value: '1' } }
      expect(response).to have_http_status(:redirect)
    end
  end
end
