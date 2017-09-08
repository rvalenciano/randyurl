# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject do
    described_class.new(url: 'http://someurl/something/over/the/rainbow',
                        minified_url: 'http://localhost:8080/y/j7t')
  end

  let!(:unaccessed_url) { create :url }
  let!(:accessed_url) { create :url, :accessed }
  let!(:accessed_once) { create :url, :accessed_once }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a access' do
    subject.access = nil
    expect(subject).to_not be_valid
  end

  it 'unaccessed is not valid without a url' do
    unaccessed_url.url = nil
    expect(unaccessed_url).to_not be_valid
  end

  it 'accessed is not valid without a url' do
    accessed_url.url = nil
    expect(accessed_url).to_not be_valid
  end

  it 'process url called once increases accesses by one' do
    url = Url.process_url('http://someurl/something/over/the/rainbow')
    expect(url.access).to eq accessed_once.access
  end

  it 'verifies encode url works' do
    url = Url.process_url('http://someurl/something/over/the/rainbow')
    expect(url.minified_url.split('/').last.length).to eq accessed_once.minified_url.split('/').last.length
  end

  it 'verifies decode url works' do
    url = Url.process_url('http://someurl/something/over/the/rainbow')
    expected_id = url.id
    decoded_url = Url.decode_url(url.minified_url)
    expect(decoded_url).to eq 'http://someurl/something/over/the/rainbow'
  end
end
