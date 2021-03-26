RSpec.describe ApiController, 'Postcode Checker API', :db do
  include Rack::Test::Methods

#    def app
#
#      PostcodeChecker::API.new()
#    end

  def post_postcode(url, postcode, status)
    post url, JSON.generate(postcode)
    expect(last_response.status).to eq(200)
    parsed = JSON.parse(last_response.body)
    expect(parsed).to include('status' => a_kind_of(String))
    postcode
  end



  context 'when user submit postcode for check' do
    let(:valid_postcode) { { 'value' => 'SH241AA' } }
    it 'validate postcode' do
      post '/checks', JSON.generate('value' => 'SE7 1AA')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include( JSON.generate('status' => 'valid') ) 
    end
    it 'submit allowed postcode 2 to check' do
      post '/checks', JSON.generate('value' => 'SH24 1AA')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include( JSON.generate('status' => 'valid') ) 
    end
    it 'submit allowed postcode 3 to check' do
      post '/checks', JSON.generate('value' => 'SE1 7DQ')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include( JSON.generate('status' => 'valid') ) 
    end
    it 'submit allowed postcode 4 to check' do
      post '/checks', JSON.generate('value' => 'SE1 7QA')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include( JSON.generate('status' => 'valid') ) 
    end
    it 'submit not allowed postcode to check' do
      post '/checks', JSON.generate('value' => 'RM3 0PD')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include( JSON.generate('status' => 'valid') ) 
    end
  end

  context 'when user submit allowed postcode' do
    it 'record allowed postcode' do
      post '/allowed_postcodes', JSON.generate('value' => 'SH24 1AA')
      expect(last_response.status).to eq(200)
      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('postcode_id' => a_kind_of(Integer))
    end
  end

  context 'when user wants to see list of allowed postcodes' do
    it 'get list of postcodes' do
#      pending 'Need to persist postcodes'
      post '/allowed_postcodes', JSON.generate('value' => 'SH24 1AA')
      post '/allowed_postcodes', JSON.generate('value' => 'SH24 1AB')
      postcode1 = { 'id' => 1, 'value' => 'SH24 1AA' }
      postcode2 = { 'id' => 2, 'value' => 'SH24 1AB' }
      get '/allowed_postcodes'
      expect(last_response.status).to eq(200)
      parsed = JSON.parse(last_response.body)
      expect(parsed).to contain_exactly(postcode1, postcode2)
    end 
  end
end