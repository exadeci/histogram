require 'rails_helper'

RSpec.describe PageViewsController, :type => :request do
  before {allow_any_instance_of(Elasticsearch::Transport::Client).to receive(:search).and_return(true)}

  context 'when parameters are sent' do
    let(:arguments) {{before: 1520469267124, after: 1488340603000}}

    it 'returns 200 status code and the results' do
      post '/page_views/histogram', params: {page_view: arguments}

      expect(response.status).to eq(200)
    end
  end

  context 'when a required parameter is missing' do
    let(:arguments) {{after: 1488340603000}}

    it 'returns an error with a message' do
      post '/page_views/histogram', params: {page_view: arguments}

      expect(response.status).to eq(422)
      expect(response.body).to include('error')
      expect(response.body).to include("can't be blank")
    end
  end

  context 'when a required parameter is wrong' do
    let(:arguments) {{before: 12, after: 1488340603000}}

    it 'returns an error with a message' do
      post '/page_views/histogram', params: {page_view: arguments}

      expect(response.body).to include('error')
      expect(response.body).to include('must be in epoch milliseconds')
    end
  end
end