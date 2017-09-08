# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :controller do
  let!(:urls) { FactoryGirl.create_list(:url, 200) }

  it 'returns all urls' do
    get :index
    expect(JSON.parse(response.body).size).to eq(200)
  end

  it 'returns status code 200' do
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'returns top urls' do
    get :top
    expect(JSON.parse(response.body).size).to eq(100)
  end

  it 'returns status code 200' do
    get :top
    expect(response).to have_http_status(:success)
  end
end
