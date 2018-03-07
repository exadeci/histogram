require 'rails_helper'

RSpec.describe PageViewsController, :type => :request do

  it 'retrieves urls stats from elasticsearch' do
    get '/page_views/histogram'
    expect(response).to render_template(:new)

    post '/widgets', :widget => {:name => 'My Widget'}

    expect(response).to redirect_to(assigns(:widget))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include('Widget was successfully created.')
  end

  it 'does not render a template' do
    get '/page_views/histogram'
    expect(response).to_not render_template(:histogram)
  end
end