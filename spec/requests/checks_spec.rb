# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Checks', type: :request do
  describe 'GET /checking' do
    it 'returns http success' do
      get '/checking'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post /checks/perform', type: :request do
    it 'returns http success' do
      post '/perform', params: { check: { value: '1' } }
      expect(response).to have_http_status(:redirect)
    end
  end
end
