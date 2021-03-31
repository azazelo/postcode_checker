# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Districts', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/districts/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/districts/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/districts/index'
      expect(response).to have_http_status(:success)
    end
  end

  let!(:district) { District.create(name: '111') }
  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete "/districts/#{district.id}"
      expect(response).to have_http_status(:redirect)
    end
  end
  context 'when id not valid' do
    it 'rises an error' do
      expect { delete '/districts/100000' }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
