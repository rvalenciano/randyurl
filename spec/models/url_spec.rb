# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject do
    described_class.new(url: 'http://someurl/something/over/the/rainbow',
                        minified_url: 'http://randyurl.com/j7ve58y')
  end

  let!(:unaccessed_url) { create :url }
  let!(:accessed_url) { create :url, :accessed }

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
end
